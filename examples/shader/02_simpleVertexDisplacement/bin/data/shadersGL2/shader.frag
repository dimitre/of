OF_GLSL_SHADER_HEADER

varying vec4 globalColor;

void main()
{
    // globalColor is being set inside the vertex shader.
    // the fragment color is then set to the globalColor.
    gl_FragColor = globalColor;
}
