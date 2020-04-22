Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _Color ("MainColor", color) = (1,0.5,0.5,1)
    }
    SubShader
    {
        Pass
        {
            Material {
                Diffuse [_Color]
            }
        Lighting  On
        }
    }
}
