'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "da5936353dc393ba760d54ce4d739e23",
"index.html": "99238b0a6e0528f2a9bc6c47e5879fb7",
"/": "99238b0a6e0528f2a9bc6c47e5879fb7",
"main.dart.js": "e5ed75c1ddfde130efadce3821b48fce",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "a0bee5cfd9ee514861a005d22ec5e448",
"assets/AssetManifest.json": "952fbb472aec99db7a3ba868cd1386b3",
"assets/NOTICES": "494259cd318b3128084a846d3d432f9a",
"assets/FontManifest.json": "9edfcaafddf9ab34664889022f173b04",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/fonts/NotoSansKR-Bold.otf": "b59ac7cf449e57469daf2480fafbddf4",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/fonts/NotoSansKR-Regular.otf": "913f146b0200b19b17eb4de8b4427a9c",
"assets/assets/splash/Img_Splash.png": "79ff0c4e8d8a19ab375024d2eec61fc8",
"assets/assets/splash/Img_Icon.png": "181c8053e4578ac13d18b0bd61b70710",
"assets/assets/access/ic_storage.svg": "ad5890a6648c2eb7f9bb8727de4f6b91",
"assets/assets/access/ic_camera.png": "c689d724ef6f79874839fcbb8cd3c495",
"assets/assets/access/ic_gps.png": "0267f5c14f5415d60e2acc4a8d444ef6",
"assets/assets/access/ic_internet.png": "d10777ef44a0efc3dc808a1e82094ff0",
"assets/assets/images/orderImage.svg": "28b2931bc35152eab3b60a4dc350c5cd",
"assets/assets/images/thumbnail.png": "a2896943e0eab68b32ae56a0d89508f7",
"assets/assets/images/location.svg": "d0c2a76fe5664c21a05a9e9b6cb8a9c1",
"assets/assets/icons/emptyOrder.svg": "d2893c5af78453ce6a125dc7a076e967",
"assets/assets/icons/ic_coldIcon.svg": "4e469b83fce5698b4c8cefb8603e5b7b",
"assets/assets/icons/emptyStore.svg": "e05f50fb4cb22206866c8400168e5aba",
"assets/assets/icons/deleteIcon.svg": "91107d69d876d880a8e29f6b77e054f8",
"assets/assets/icons/ic_delete.svg": "ebd00a6daad4d4dd7ce2828acda698ff",
"assets/assets/icons/hotOnlyIcon.svg": "0ee59867a9df6d11e88d01969d9be4a2",
"assets/assets/icons/normalIceSize.svg": "cfa3c8584f7dde33760070532e8b930b",
"assets/assets/icons/ic_card.svg": "483fecc0351d0a911736e32c4442464f",
"assets/assets/icons/logout.svg": "298ddfe2c9558634afbfad8906eeda9d",
"assets/assets/icons/withdrawal.svg": "4bb8b6c3c16b672b38c6e66c87ec39ae",
"assets/assets/icons/emptyMenu.svg": "4d2fc2144ebc62a3b01b4f53ff62327e",
"assets/assets/icons/ic_nowLocation.svg": "2526dde956d58a2a39dbff05d55eb741",
"assets/assets/icons/arrowdown.svg": "ce0e24148e6357daa08dfeb30df02061",
"assets/assets/icons/ic_syrup.svg": "0f2b874a8617c039ef23ad15d8e65b15",
"assets/assets/icons/kakaoIcon.svg": "aa765ac3556962626551766a8a23dfb4",
"assets/assets/icons/iceOnlyIcon.svg": "e9144527d21550f3f89b979d6f70a20b",
"assets/assets/icons/ic_requestOrder.svg": "bd1b88754bdd032ea78dcbc551bff4c4",
"assets/assets/icons/searchIcon.svg": "1fc0cd11a78f915685472ae119e14f07",
"assets/assets/icons/ic_refresh.svg": "147258d2cffdd814e4cd60a0c8a6f1df",
"assets/assets/icons/ic_hotIcon.svg": "7ceccacf94cfcda9bd5d0a443baf5e00",
"assets/assets/icons/takeoutIcon.svg": "af8f193db9fc037b949d9e5397735eb6",
"assets/assets/icons/arrowRight.svg": "a3715ad882e248cbbd75c3058e8b338b",
"assets/assets/icons/ic_whipping.svg": "865452eb434356aab0dea67cf74816fb",
"assets/assets/icons/ic_nowShop.svg": "a0e223cb6fbafe33b5103b37c790e6d0",
"assets/assets/icons/largeIceSize.svg": "e5a9e36e9fc6c97c4560cb28fe7c81cd",
"assets/assets/icons/plusIcon.svg": "52ca975e486000fe3334e64506c7fb05",
"assets/assets/icons/ic_shoppingCart_white.svg": "dd2552a063feb3754e5ad0553a218199",
"assets/assets/icons/bell.svg": "79b8d16d60147c6c07183cc1ebb8ea3b",
"assets/assets/icons/smallIceSize.svg": "8006e4ca18faada87399ec1ac66fe1e0",
"assets/assets/icons/arumDreamLogo.svg": "a02825b39e7d6c6672df34dec6a3a8a2",
"assets/assets/icons/ic_requestApprove.svg": "3b601983fd8fcb3d2c41675ae398e08b",
"assets/assets/icons/ic_qrcode.svg": "964a8c1ec0067aa37b566f6d51033d3e",
"assets/assets/icons/icShot.svg": "eaef298fe5bb17a39d76713565ab5ff5",
"assets/assets/icons/backIcon.svg": "15e68321872bc04e3de95088153683ce",
"assets/assets/icons/appleIcon.svg": "757cf23f49e2e889886e97ecc39e96ce",
"assets/assets/icons/emailIcon.svg": "74475524d3b3df0c5aa5746915ce6cae",
"assets/assets/icons/Ic_EmptyCoupon.svg": "1d176c02a353e75be019851470ff9d7f",
"assets/assets/icons/trash.svg": "0bab638efb5bbc82bf3745a36c7b3f27",
"assets/assets/icons/ic_produce.svg": "824de7f1a3c312ca42f31e2d66fb24b2",
"assets/assets/icons/orderCartIcon.svg": "a5e57387ec5e6727f9ca7254b01136ad",
"assets/assets/icons/ic_hotAndice.svg": "567a27cd4a408575fa690d145a6228f8",
"assets/assets/icons/ic_allClear.png": "e47a6588313c06b9f1afdbe13b68d38e",
"assets/assets/icons/orderNowIcon.svg": "7c2266232744188f3c9aaa07d414c213",
"assets/assets/icons/tableIcon.svg": "a7c7ef51af781313c2ffd35ea0a4acfc",
"assets/assets/icons/ic_coin.svg": "e3effd8014d1b0fc2f1ad62e9cde8f0f",
"assets/assets/icons/ic_allClear.svg": "8c8487e6b227572263531791fa83095b",
"assets/assets/icons/profile.svg": "8e5e934922d033811c427648b0ff7d91",
"assets/assets/icons/ic_payment.svg": "cb531915a8201887b7cd3bca8e8545f9",
"assets/assets/icons/ic_placeholder.svg": "16ccc58c62c7ee575482b618b2d1e18d",
"assets/assets/icons/favIcon.svg": "fc3d2ba4eaf9cd4546645289f16e260d",
"assets/assets/icons/minusIcon.svg": "49c50b3c78cdbd08a5297dd72ffd9239",
"assets/assets/icons/ic_nonCart.svg": "f2ec62337595e6feafdef864fa23b03f",
"assets/assets/icons/stamp.svg": "11bf1c2f02aaf7900c51936a5a39626c",
"assets/assets/bottomNav/icOrderSelected.svg": "b8dbf61666c4b51a3e83de2eff5c11ca",
"assets/assets/bottomNav/icMyPage.svg": "6c25b257b45b9cd7c65b68ca167da686",
"assets/assets/bottomNav/icFavSelected.svg": "404fbf88f556fe5204519a64f47b2f10",
"assets/assets/bottomNav/icOrder.svg": "ac258609f3701000e5960b6904703f25",
"assets/assets/bottomNav/icMyPageSelected.svg": "42a2dfca3b9812ae4020a8bf492808b9",
"assets/assets/bottomNav/icHomeSelected.svg": "fb0cbcd3ac87805f9311d20271e66107",
"assets/assets/bottomNav/icFav.svg": "f40d62f3601b18aad30e95c6e3e401a6",
"assets/assets/bottomNav/icHome.svg": "c413a447b5029329a68e5d1c6a2d9614"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
