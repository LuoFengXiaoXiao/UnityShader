

Shader "Unlit/Sample"
{
    Properties
    {
        //_MainTex ("Texture", 2D) = "white" {}
        _Texture("Texture",2D) = "White" {}
        _Color("Color",Color) = (1,1,1,1)
    }

        SubShader
        {
            Tags{"Queue" = "Geometry"  "RendeeType" = "Opaque"}
            LOD 100

            Pass
            {
                CGPROGRAM

                #pragma vertex vert
                #pragma fragment frag

                sampler2D _Texture;
                fixed4 _Color;

                // 输入参数
                struct appdata {
                    fixed4 vertex : POSITION;
                    fixed2 uv : TEXCOORD0;
                };

                // 透视处理，光栅化
                struct v2f {
                    fixed4 vertex : SV_POSITION;
                    fixed2 uv : TECOORD0;
                };

                // 根据输入参数，变换之后渲染到屏幕上
                v2f vert(appdata i)
                {
                    v2f o;
                    o.uv = i.uv;
                    o.vertex = UnityObjectToClipPos(i.vertex);
                    return o;
                }

                fixed4 frag(v2f v) :SV_Target  //渲染的目标
                {
                    return tex2D(_Texture,v.uv) * _Color;
                }
            ENDCG
            }
        }
   
}
