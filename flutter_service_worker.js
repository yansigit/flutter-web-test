'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "da5936353dc393ba760d54ce4d739e23",
"index.html": "1fdc45245ae79aad20bf7379b642c1e7",
"/": "1fdc45245ae79aad20bf7379b642c1e7",
"main.dart.js": "c3c6f505cc5e60b8639b57c8a784722a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "a0bee5cfd9ee514861a005d22ec5e448",
".git/config": "2efd84cbdcd18c22e0dc9b8d62f3e032",
".git/objects/59/d165d58236d8c76b1fc33f175c0f1e2e225dd4": "16ca3f3b9a492e736b1c591f68e28aad",
".git/objects/57/e052a39743f92c0abdfaabda791a9eda4a268a": "06a6f1b33a3860168f67ea6392a59890",
".git/objects/6f/266549eff1a536d122a620e7e4ae5732128242": "95f3db7d1286fa9d6d4d86ea04e12cd0",
".git/objects/03/80d546bc76441ce6f569d4c8f0ba78cf6e0db4": "06f9f9533c309bf9daf244eb30fda290",
".git/objects/03/a3f6671fe5124286723b6cce5edb68075296bd": "95ec8c7b8ffc2c394f2cebe7af8afb7e",
".git/objects/03/65a389ba2524c70455dfd6b7b26a8167dde46b": "4b7af7960fd7792209fd8ae34c50ce00",
".git/objects/9e/9d229a17fdb8c655775238534382a7508be99d": "083e42bfe8e5228c570409a8cedede90",
".git/objects/9e/f707c11d51219a102e527590e0dc38c2b6be86": "1e8dd6f2a5b118a5fd3400f7379e71e0",
".git/objects/32/46ad559eeae0370195978eaed83f1053ee13fd": "a043dbc0a0bda96ce2127799ccc27506",
".git/objects/32/e701b3c2b2a28e2ef62f01bc77816a6ed937b2": "4513ec3db3d80c5eabd934753abc6436",
".git/objects/93/52c9402e43a7882e3d2039f8e6c74966cad916": "f6a318235fb61ea7b1ba6fcb4fea11a0",
".git/objects/0e/297ec2c74b7f95b2741901b4cf18b69cedf8e1": "57bf6ac3f6f43222416dbbdbe7feb170",
".git/objects/34/cd7792418f68ee86db3ceb216c2d28dc605ecc": "5f3e37d68e54e24172ba50738dfbc37d",
".git/objects/5a/df3048dbd65c0f9bfd88bab05e0be573280dfa": "131cd06f5345b14e11dea0ff876a100a",
".git/objects/5f/f41e3225675c33713efea2cab0aa65454dab27": "c254c663a4d6bd0ea6686efff24aef37",
".git/objects/d9/a611eaf0d9eaf18fd2c3c9d6417272f6a771cc": "4f4edec4b10d92d82a6a25cc20003b7b",
".git/objects/ad/f2c043c17656e807133425f2c9b0184d877dab": "103303179a321cfee7d5ae806183f308",
".git/objects/d7/31976690103236e868af5323debc18a8e12e41": "cda2531c214856f01a3d1b714dd1882b",
".git/objects/b4/cd1ab3cbe11f5ad437cf841d7a0ccf5cf4067a": "35b7ea58d66830c1612c526b3803bdcd",
".git/objects/a5/9ab997b1338a15a594ad7caf4aa73f5bb5a515": "5fed1e4edeaece4855697eadab230188",
".git/objects/a5/0f1ef3b8674187aed470e8ec68bc79f4f464de": "a31296cb7819e15ff9cf0a03790d11a0",
".git/objects/bc/39a547d09d6ec54810459fdb755e4284691194": "22f4fe22091e264a4713748b7a3c335e",
".git/objects/ae/68ab29ea62c24e9a77ad765e386e6687665c2f": "0c1f3e27f80e7acca3309745097b4cf5",
".git/objects/d8/9b5ed52704f0e9ddc09f4f4db9c6fa526bef43": "cbdec3ab05298dabb34e293c30cc19ba",
".git/objects/ab/0e98497a51ead7821d1da35a24968ff314e50f": "557c35fe3928eb2af403d1b3926bb9ba",
".git/objects/e5/951dfb943474a56e611d9923405cd06c2dd28d": "c6fa51103d8db5478e1a43a661f6c68d",
".git/objects/e5/87cb465f6f412996f5f23707c4f8cf6e5b9d33": "d1eb9908b7a65f7012b0cedcf6f4ccf7",
".git/objects/e2/6c1cd350870002012b12345aa8999228806332": "c3ee09e19e7dc55a0d1dd92c14a4cfcc",
".git/objects/f3/0020e55dab2191c12d3a493a46a1da10907aea": "c96e630841e07ff7de97658c8431be90",
".git/objects/f3/4711a4c4667562fdfa259cb84ec35e31f6bc1c": "060923c0a6f9ffc0fe3992a8c245c067",
".git/objects/c7/764ad30bd53f85ed995f3d39f77cb4733c1c31": "5b6886aad0b0d0f7a777af77b3c1f6aa",
".git/objects/fd/76c009c24c9ca4e236e848c75a1999a1b1f281": "2a560348da0ae7e4981dd1b4a5644d86",
".git/objects/e3/a7cfa88455920e1e2313e6a750f0e2b58b6b6c": "f0514a97f757631d3651aa70fcf3b283",
".git/objects/fe/f8549340b23c904b857cd3024155525be83637": "85d1dedddf55804c36fd10b486865f4f",
".git/objects/ec/45638c69d50a8d5defed230fafd380ec88fb81": "d1082cc02fcc96a501c0aaec55528d34",
".git/objects/ec/38d55712f998ca6713699594c3a4ef3ebb9869": "05fd7865e1353860c401e253763ff8f7",
".git/objects/20/d62b0333498cf243758af6eb7497b3b1f19217": "3e62a7c0141b0dbf525e1aca9567889e",
".git/objects/11/50727faec736bc31b9773670ae2683de4cffab": "4d53903d69da77b6c1d904117fa2c041",
".git/objects/7d/0ca90df567eb4510f0043152899e46ebc61df6": "f4ff901a7b9eb6d2832e11fc42c193a7",
".git/objects/73/91362c22646b04a03992065b0c256012d1f086": "73e554f63b2c1084dbfb54d0bbf3b2ab",
".git/objects/74/de6a43ff3c7498fadd3217dda69a654f1b5d0c": "e44dcf4f3803760c1a146849a6ab8235",
".git/objects/8f/637201d774968d6eba626e212647a4b7ae5c27": "32308ba05cedb4673533d08991e296c2",
".git/objects/8f/7d0f89e24652b7fc43fcda8d0d99d8b5f92593": "e8c4b63cee08ef2fc89334ecad37d14d",
".git/objects/8a/eafd1b0caeebe46b27b5bd2577a7548cec5d66": "721600f161728632cbe7b40e71694c34",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/4c/91c7d2e4a3703d5d145dacfd04221337c32006": "684ba4ad86b1e07078a803c558362e22",
".git/objects/26/b0222f58471bd79fb2b0f76272ba77c3911f2b": "5402cea134946c4106c47c012beed078",
".git/objects/21/a2168d94883970a05029e90bf2f9d45713085c": "58a150d046d05a0cdcdde7c680e3026f",
".git/objects/4d/c4dbd69f6ee0eb2b1b8748477044aead223149": "ea6163fa9671bf4aa687c07398b31519",
".git/objects/81/9415a325bc592f165203cb8d3664cc2ad0305f": "81daf18ce137583824e036f371f873ed",
".git/objects/81/657b2f98d8fd4dc81c25d1fe972b8689c8e514": "4de616e5606a9c48cef63a3945b9d75d",
".git/objects/86/2141c4138fb818a05de5b922e2a97be4a1682e": "f6512452ba0597fa7cb6ddf1e47c5879",
".git/objects/86/d7036b89bd6314a3bcfa37aa51a25ce6b13930": "ee5557813b77e41819d7b42416574d36",
".git/objects/2a/f1b6921ce9811c4988fe623b562fbe4f3e76a1": "f8e75230986ef033cc3defec4d50baa5",
".git/objects/43/68f53216830d799ffb75a7783ab6ee09835e72": "9aed1f83287276778dbdcbf1c001b86d",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/6b/fefccc8eb5874e00eb5fe5048f2f457b17c346": "0877a2464fca40e7747ecb60aa4cc350",
".git/objects/38/4ddcf544a7ff6bffe024bc85a693f4823b7c7b": "c68db6b0c0a746044af3874500f4d38d",
".git/objects/9a/486093a492e32660252648602f9f40d5754ac4": "e238aaf2b37b25b07fcb791ca8a2216c",
".git/objects/36/2392c534c06de49e50a94c2675c67f38a54d88": "130bed08d6762d311d674fcc49d1a5aa",
".git/objects/96/e32d2e49e272b92f88794bbb167bd36aa1c21a": "f2316c2934b9de4969b965585f71e044",
".git/objects/3f/5f759ba2de60b53d5bd662c6ff352bd496425c": "2499e520886df9a97d6b4bd7eee7c405",
".git/objects/5e/941751d7a7e69f4980fbd231647b7603c373e8": "ba59ce8b6bf6371a01026b93d78f803f",
".git/objects/06/9280a42d1a7a5f6166cdf420278727099f7d3c": "02a6e9b6ae089a6986604eecb42648c8",
".git/objects/0a/a7c51a496efe7e0601e117a711b1e37666e3aa": "ba250b672b7b7756eb7c37cad4d6bb68",
".git/objects/d4/707772fb5342a86b5b1c3561525dbfa1e8d97d": "846957ca8670f46c3bba11adf927d85e",
".git/objects/a7/6311e58a155329ed74d82736d86eafef37902c": "2777fa75f07d35dd11bfbccbc434845c",
".git/objects/a9/21ac80d28228141b3ad3d78b865c4353487601": "50728151b05bd89c832426434619e16c",
".git/objects/d2/07c739f8f67b79ddcc0619f22cf454d5705e95": "ec91d596baf857696ba324a09149ad4d",
".git/objects/d2/b9a6a643db06965fea422b355ea69bbf4f5e8e": "509216a85cccfdad04969206388d4f25",
".git/objects/af/e733ec640ee9450ee08472aab49f3a2cc1ebfe": "4967fed373c1a2ebc8d535f2ec2dde62",
".git/objects/af/5c64a5402f58017b1d078f92b8d3b5d53a41d7": "3f15b2aff2ba2a5b46e444a78c1bee6c",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/db/bb37ca78bc098046b10d753ac2ecec09e3d603": "7ad1e0c36e5b76797ba12541bc0afb8e",
".git/objects/a1/ff56992bb1a00112f86dcb85c97c812851a8ba": "c26704dda1b20fa35c5d9724788b5b83",
".git/objects/a1/3837a12450aceaa5c8e807c32e781831d67a8f": "bfe4910ea01eb3d69e9520c3b42a0adf",
".git/objects/ef/ed3ee1b418f25f072855fcf37486b3a85ef057": "22f295211b09326502b424c6efb96c1d",
".git/objects/c3/d81eae5c5b5d566781a3d8ee860ba770ab8ebd": "a45a53fa95a0a15fe934d52666f082d5",
".git/objects/ea/ba218b8ca39536a9ff9785bda82be192db1a83": "9488c15ec1a14c660ba08d50965cb905",
".git/objects/e1/4f9567cba8f1e6df00f550efed999f738b8325": "08474a300f004797110607a87004976e",
".git/objects/c2/e52501d428ffed23e2868f0d1c0e6a31b531ae": "f22c7187028a47ee57cea9a4b0e718ca",
".git/objects/e7/acb94836dda73702770ff0e75244900d81afe8": "e7be98c048973373449b968b701b2e15",
".git/objects/e7/5410a26568196e67907ab2bff9ebbdc5e14134": "523334586c8f051072cde301db121e92",
".git/objects/2c/c0ce9728ab07a12b3d509f49709491e5f588ee": "0e17957e21ce30da8f9fa348d0b7e435",
".git/objects/79/ba7ea0836b93b3f178067bcd0a0945dbc26b3f": "f3e31aec622d6cf63f619aa3a6023103",
".git/objects/2d/444e45bb50e036675cd16c3d1cdb2f59def04e": "68793eaf10b4e66b8c377df052244060",
".git/objects/83/be394a37aeea7d1f953349b3c24d39bab96006": "0fc85a0252d9fe39e2709266385c0b62",
".git/objects/70/ab39e88dede51f1638ccfb0586c03bda0e49f8": "3f8e6d6fadd4512d7e17ef35957dc433",
".git/objects/84/c11b23408ecc05089326d09e4dce69fe65e5ea": "937cbc9b94a91d51e5d2390f6ae06b60",
".git/objects/4a/c20f5385a36a256f72da100e59dee73c8d4995": "c0711176455a9b81d9816a57fa03fcc6",
".git/objects/4f/dced7d54023f473b03d7c65175b4e7ad5b979f": "81389781d5aec2cdb027ae41daca722c",
".git/objects/12/edd0136b1a9ed26d612c008834dc234aee1b80": "1eec162ce5d2b36ab5d67bc6242e5d04",
".git/objects/8c/2d2d91f0f6d91a13b8da823bc120b91b21591e": "90fbf99511d6b5c777e56ac50627f4f4",
".git/objects/71/1d09986de3666793c94faffc1f289bf7f3dc19": "aa3ff5620f46f6b5e311bd7963aed91f",
".git/objects/40/fa2197d2a5953fd2c22c1b92c8b05feaea07ef": "dd6020c9b42f67f5b4a29e4a4a59cf4e",
".git/objects/2b/f722efab8869314182ee5f85398b67f2695db1": "9bfb473f38e80f66f029dd64d993c0fb",
".git/objects/47/479947e00e71870e05b868c6c143b9952d6aab": "825ef30e8fe083c77b021c203e71c4ed",
".git/objects/78/39da9e920cf3accaa4c23debc50092324eede3": "d3e8fbe364f4625e5dfad5ae862b4ffb",
".git/objects/7f/4131ce7aa75733a51b7035ade7fe1d91f607ac": "07a9f8d5171b64159c504efe0537515f",
".git/objects/25/92e93fcfc5a495ec10fcbf23835babb1122a45": "b31c92631f1b7c37aaa10851233a54a3",
".git/HEAD": "4cf2d64e44205fe628ddd534e1151b58",
".git/info/exclude": "0aebccfd5866bfc3e7c8f625230c22f7",
".git/logs/HEAD": "882760738c686d9b77a0619f3bccec39",
".git/logs/refs/heads/master": "882760738c686d9b77a0619f3bccec39",
".git/logs/refs/remotes/origin/master": "4493033f4ad8da02f0bb5a1dd67cb7cb",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "e4db8c12ee125a8a085907b757359ef0",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "ecbb0cb5ffb7d773cd5b2407b210cc3b",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "3c5989301dd4b949dfa1f43738a22819",
".git/hooks/update.sample": "517f14b9239689dff8bda3022ebd9004",
".git/refs/heads/master": "ef5f57d7f7004498d37459acf7ca175d",
".git/refs/remotes/origin/master": "ef5f57d7f7004498d37459acf7ca175d",
".git/index": "a90ef4702c77734ba01a0f54d05dbf8f",
".git/COMMIT_EDITMSG": "f497c39a0cb8c117c25f827e5b403e36",
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
