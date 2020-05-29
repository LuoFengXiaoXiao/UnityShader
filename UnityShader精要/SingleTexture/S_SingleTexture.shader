Shader "Custom/S_SingleTexture"
{
    Properties
    {
        _MainTex("Main Tex",2D) = "white"{}
        _Diffuse("Diffuse",Color) = (1,1,1,1)
        _Specular("Specular",Color) = (1,1,1,1)
        _Gloss("Gloss",Range(8.0,256)) = 20
    }
        SubShader
    {

        Pass
        {

            Tags{"LightMode" = "ForwardBase"}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Lighting.cginc"

            fixed4 _Diffuse;
            fixed4 _Specular;
            float _Gloss;
            sampler2D _MainTex;
            float4 _MainTex_ST;

            struct a2v
            {
                float4 vertex : POSITION;
                float2 normal : NORMAL;
                float4 texcoord:TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldNormal:TEXCOORD0;
                float3 worldPos:TEXCOORD1;
                float2 uv:TEXCOORD2;
            };

            v2f vert(a2v v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);

                // Transform the vertex from object space to world space
                o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);

                // Transfrom the vertex from object space  to world space
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                ////o.uv = v.texcoord.xy * MainTex_ST.xy + _MainTex_ST.zw;
                //o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                o.uv = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                // Or just call the built-in function
                //o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {

                fixed3 worldNormal = normalize(i.worldNormal);
                fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);

                // Use the texture to sample the diffuse color
                fixed3 albedo = tex2D(_MainTex, i.uv).rgb * _Diffuse.rgb;

                // Get ambient term
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz*albedo;

                // Compute diffuse term
                fixed3 diffuse = _LightColor0.rgb * albedo * max(0,dot(worldNormal, worldLightDir));

                //// Get the reflect direction in world space
                //fixed3 reflectDir = normalize(reflect(-worldLightDir, worldNormal));

                // Get the view direction in world space
                fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);

                // Get the half direction in world space
                fixed3 halfDir = normalize(worldLightDir + viewDir);

                // Compute specular term
                fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(max(0,dot(worldNormal,halfDir)),_Gloss);

                return fixed4(ambient + diffuse + specular, 1.0);
            }
            ENDCG
        }

    }
        Fallback "Specular"
}
