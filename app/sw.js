// sw.js

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open('morganism-v1').then(cache => {
      return cache.addAll([
        '/',
        '/help',
        '/about',
        '/login',
        '/logout',
        '/contact',
        '/settings',
        '/home',
        '/admin',
        '/debug'
      ]);
    })
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request).then(response => {
      return response || fetch(event.request);
    })
  );
});

