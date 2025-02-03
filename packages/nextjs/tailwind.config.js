/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./pages/**/*.{js,ts,jsx,tsx}", "./components/**/*.{js,ts,jsx,tsx}", "./utils/**/*.{js,ts,jsx,tsx}"],
  plugins: [require("daisyui")],
  darkTheme: "scaffoldEth",
  // DaisyUI theme colors
  daisyui: {
    themes: [
      {
        scaffoldEth: {
          primary: "#00ff3c",
          "primary-content": "#000000",
          secondary: "#84ff00",
          "secondary-content": "#000000",
          accent: "#FF6347",
          "accent-content": "#000000",
          neutral: "#212638",
          "neutral-content": "#FFFFFF",
          "base-100": "#000000",
          "base-200": "#F9FBFF",
          "base-300": "#DAE8FF",
          "base-content": "#FFFFFF",
          info: "#FF4500",
          success: "#FF6347",
          warning: "#FFA500",
          error: "#B22222",

          "--rounded-btn": "9999rem",

          ".tooltip": {
            "--tooltip-tail": "6px",
          },
        },
      },
    ],
  },
  theme: {
    // Extend Tailwind classes (e.g. font-bai-jamjuree, animate-grow)
    extend: {
      animation: {
        "pulse-fast": "pulse 1s cubic-bezier(0.4, 0, 0.6, 1) infinite",
      },
    },
  },
};
