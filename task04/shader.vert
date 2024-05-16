#version 120

// see the GLSL 1.2 specification:
// https://www.khronos.org/registry/OpenGL/specs/gl/GLSLangSpec.1.20.pdf

uniform bool is_reflection; // variable of the program
varying vec3 normal; // normal vector pass to the rasterizer and fragment shader

void main()
{
    normal = vec3(gl_Normal);// set normal and pass it to fragment shader

    // "gl_Vertex" is the *input* vertex coordinate of triangle.
    // "gl_Vertex" has type of "vec4", which is homogeneious coordinate
    float x0 = gl_Vertex.x/gl_Vertex.w;// x-coord
    float y0 = gl_Vertex.y/gl_Vertex.w;// y-coord
    float z0 = gl_Vertex.z/gl_Vertex.w;// z-coord
    if (is_reflection) {
        vec3 nrm = normalize(vec3(0.4, 0.0, 1.0)); // normal of the mirror
        vec3 org = vec3(-0.3, 0.0, -0.5); // point on the mirror
        // wite code to change the input position (x0,y0,z0).
        // the transformed position (x0, y0, z0) should be drawn as the mirror reflection.
        //
        // make sure the occlusion is correctly computed.
        // the mirror is behind the armadillo, so the reflected image should be behind the armadillo.
        // furthermore, make sure the occlusion is correctly computed for the reflected image.
        //x0 = ???
        //y0 = ???
        //z0 = ???

        
//        mat4 coeff = mat4(
//          nrm[0],nrm[1],nrm[2],0,
//          1,0,0,nrm[0],
//          0,1,0,nrm[1],
//          0,0,1,nrm[2]
//          );
//
//        vec4 rhs= vec4(nrm[0]*(-0.3) + nrm[1]*(-0.5),x0,y0,z0);
//        mat4 i_coeff = inverse(coeff);
//        vec4 sol= i_coeff*rhs;
//
//        float c=sol[3];
//        float z=sol[2]-nrm[2]*c;
//        x0 = sol[0] - c*nrm[0];
//        y0 = sol[1] - c*nrm[1];
//        z0 = z;

        vec3 dp=vec3(x0,y0,z0) - org;
        float dt=-dot(nrm,dp);
        vec3 rp=vec3(x0,y0,z0)+ 2*dt*nrm;

        x0=rp.x;
        y0=rp.y;
        z0=rp.z/5;

    }
    // do not edit below

    // "gl_Position" is the *output* vertex coordinate in the
    // "canonical view volume (i.e.. [-1,+1]^3)" pass to the rasterizer.
    gl_Position = vec4(x0, y0, -z0, 1);// opengl actually draw a pixel with *maximum* depth. so invert z
}
