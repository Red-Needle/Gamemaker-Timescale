varying vec2 v_vTexcoord;

void main()
{
	float alpha = texture2D( gm_BaseTexture, v_vTexcoord ).a;
    gl_FragColor = vec4(1.0, 1.0, 1.0, alpha);
}
