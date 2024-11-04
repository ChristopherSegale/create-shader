Create-Shader

---

This is a library used to create strings of GLSL code. These strings can then be combined to create programs that OpenGL will use to render images.

Refer to functions/rules.lisp to get the supported syntax available as well as how they get expanded.

Example vertex shader:
(create-shader
  (:version 330)
  (:in (:layout (:location 0)) :vec3 v-position)
  (:function :void main nil
    (:set gl-position (:vec4 v-position 1.0))))

Example fragment shader:
(create-shader
  (:version 330)
  (:out :vec4 frag-color)
  (:function :void main nil
    (:set frag-color (:vec4 1.0 0.8 0.5 1.0))))
