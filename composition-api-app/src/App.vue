<template>
  <counter-mouse :times="3"></counter-mouse>
</template>

<script>
import CounterMouse from "./components/CounterMounse.vue";

export default {
  name: "App",
  components: {
    CounterMouse,
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
