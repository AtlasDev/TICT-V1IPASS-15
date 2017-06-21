const cacheUrls = [
	'.',
	'/dist/index.js',
];

console.log('asdsad');
self.addEventListener('install', (event: any) => {
	console.log('Service worker has been installed.');
	event.waitUntil(
    caches.open('static-v1').then((cache) => {
      return cache.addAll(cacheUrls);
    }),
  );
});
