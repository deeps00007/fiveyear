#version 460 core

#include <flutter/flutter.glsl>

out vec4 fragColor;

uniform sampler2D image;
uniform vec2 resolution;
uniform vec3 keyColor;
uniform float threshold;
uniform float smoothing;

void main() {
    vec2 uv = FlutterFragCoord().xy / resolution;
    vec4 color = texture(image, uv);
    
    // Check distance between pixel color and our green background keyColor
    float diff = distance(color.rgb, keyColor);

    if (diff < threshold) {
        fragColor = vec4(0.0); // Fully transparent
    } else if (diff < threshold + smoothing) {
        // Semi-transparent for edges
        float alpha = (diff - threshold) / smoothing;
        fragColor = vec4(color.rgb * alpha, alpha);
    } else {
        fragColor = color;
    }
}
