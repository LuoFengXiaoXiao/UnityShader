

Shader "Custom/SimpleSurface" {

	SubShader {

		Tags {"RenderType" = "Opaque"}
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		//# pragma surface surf Lambert
		struct  Input {
			float4 color:COLOR;
		};

		void surf(Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = 1;
		}
		ENDCG

	}
	Fallback "Diffuse"
}

//Shader "Custom/SimpleSurface"
//{
//    SubShader
//    {
//        Tags { "RenderType" = "Opaque" }
//        LOD 200
//
//        CGPROGRAM
//        // Physically based Standard lighting model, and enable shadows on all light types
//        #pragma surface surf Standard fullforwardshadows
//        //# pragma surface surf Lambert
//
//        struct Input
//        {
//            float4 color:COLOR;
//        };
//
//        void surf(Input IN, inout SurfaceOutputStandard o)
//        {
//            o.Albedo =1;
//
//        }
//        ENDCG
//    }
//        FallBack "Diffuse"
//}
