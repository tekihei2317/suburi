<template>
  <div @mousemove="updateMouse" class="container">
    count is {{ count }}, count * {{ times }} = {{ multiplicationResult }}
    <button @click="increment">+</button>
    <div>Mouse is at {{ mousePosition.x }}, {{ mousePosition.y }}</div>
  </div>
</template>

<script>
import { reactive, ref, computed } from "vue";

export default {
  props: {
    times: {
      type: Number,
      default: 2,
    },
  },
  setup(props) {
    // counter
    let count = ref(0);
    const increment = () => {
      count.value++;
    };
    const multiplicationResult = computed(() => {
      return count.value * props.times;
    });

    // mouse
    const mousePosition = reactive({ x: 0, y: 0 });
    const updateMouse = (event) => {
      mousePosition.x = event.clientX;
      mousePosition.y = event.clientY;
    };

    return {
      mousePosition,
      count,
      updateMouse,
      increment,
      multiplicationResult,
    };
  },
};
</script>

<style>
.container {
  height: 800px;
}
</style>
