

Shader "Custom/S_Diffuse_Pixel"
{
    Properties
    {
        _Diffuse("Diffuse",Color) = (1,1,1,1)
    }
        SubShader
    {
        Pass{
            Tags {"LightMode" = "ForwardBase"}

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Lighting.cginc"

            fixed4 _Diffuse;

    // 该结构体的定义一个normal变量，并通过NORMAL语义来告诉Unity把模型的法线存储到normal变量中 
    struct a2v {
        float4 vertex : POSITION;
        float3 normal :NORMAL;
    };

    struct v2f {
        float4 pos:SV_POSITION;
        float3 worldNormal:TEXCOORD0;
    };

    v2f vert(a2v v) {
        v2f o;
        // Transform the vertex from object space to projection space
        o.pos = UnityObjectToClipPos(v.vertex);

        //// Get ambient term
        //fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

        // Transform the normal fram object space to world space
        o.worldNormal = normalize(mul(v.normal, (float3x3)unity_WorldToObject));

        //// Get the light direction in world space
        //fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);

        //// Compute diffuse term
        //fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal, worldLight));

        //o.color = ambient + diffuse;

        return o;
    }

    fixed4 frag(v2f i) :SV_Target{

        // Get ambient term
        fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

        // Get the normal in world space
        fixed3 worldNormal = i.worldNormal;

        // Get the light directioon in world space
        fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);

        // Compute diffuse term
        fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal, worldLightDir));

        fixed3 color = ambient + diffuse;

        return fixed4(color,1.0);
    }

    ENDCG
}
    }
        FallBack "Diffuse"
}
