<template>
  <div @mousemove="updateMouse" class="container">
    count is {{ count }}, count * {{ times }} = {{ multiplicationResult }}
    <button @click="increment">+</button>
    <div>Mouse is at {{ mousePosition.x }}, {{ mousePosition.y }}</div>
  </div>
</template>

<script>
import { computed } from "vue";
import { usePosition } from "../util-functions/position";
import { useCounter } from "../util-functions/counter";

export default {
  props: {
    times: {
      type: Number,
      default: 2
    }
  },
  setup(props) {
    // counter
    const { count, increment } = useCounter();
    const multiplicationResult = computed(() => {
      return count.value * props.times;
    });

    // mouse
    const { position: mousePosition, updatePosition: updateMouse } = usePosition();

    return {
      mousePosition,
      count,
      updateMouse,
      increment,
      multiplicationResult
    };
  }
};
</script>

<style>
.container {
  height: 800px;
}
</style>
