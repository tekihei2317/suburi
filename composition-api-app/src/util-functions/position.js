import { reactive } from "vue";

export const usePosition = () => {
  // mouse
  const position = reactive({ x: 0, y: 0 });
  const updatePosition = (event) => {
    position.x = event.clientX;
    position.y = event.clientY;
  };

  return { position, updatePosition };
};
