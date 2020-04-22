

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/Simple VertexFragment Shader"
{
    SubShader
    {

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            float4 vert(float4 v:POSITION) : SV_POSITION {
                //float4 o;
                //o = UnityObjectToClipPos(v);
                return UnityObjectToClipPos(v);
                //return mul(UNITY_MATRIX_MVP, v);
            }

            fixed4 frag() : SV_Target{
                return fixed4(1.0,1.0,0.0,1.0);
            }
            ENDCG
        }
    }
}
