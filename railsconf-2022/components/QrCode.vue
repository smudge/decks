<template>
  <qrcode-vue :value="value" :size="size" level="H" />
</template>
<script>
  import QrcodeVue from 'qrcode.vue'

  export default {
    data() {
      return {
        size: 300,
      }
    },
    components: {
      QrcodeVue,
    },
  }
</script>
