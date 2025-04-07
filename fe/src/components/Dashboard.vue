<template>
    <div>
        <h2>Dashboard</h2>
        <p>Welcome to your dashboard, {{ user?.email }}</p>
    </div>
</template>

<script>
export default {
    props: ['user']
}
</script>
