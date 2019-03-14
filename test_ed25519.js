//var lib = require('supercop.js');
var nacl = require('tweetnacl');

// var seed = lib.createSeed()
// var keys = lib.createKeyPair(seed)

var keys = {
  publicKey: Buffer.from('b2d286e6e2b37269c13160affba4498925ad103b5f2c196ad9f83dde5856b303', 'hex'),
  secretKey: Buffer.from('bd18c434476ed0e6e8479235b93a20b22db06b28b20148f24b44c1d50816e90ab2d286e6e2b37269c13160affba4498925ad103b5f2c196ad9f83dde5856b303', 'hex')
};

// console.log(keys);

var msg = new Buffer('abc')

// --- menggunakan Supercop
// var sig = lib.sign(msg, keys.publicKey, keys.secretKey)
// console.log(sig.toString('hex'));
// console.log(lib.verify(sig, msg, keys.publicKey)) // true

// --- menggunakan Tweet NaCL

var sig = nacl.sign.detached(msg, keys.secretKey);
console.log(toHexString(sig));

console.log("is verified: " + nacl.sign.detached.verify(msg, sig, keys.publicKey));

function toHexString(byteArray) {
  return Array.from(byteArray, function(byte) {
    return ('0' + (byte & 0xFF).toString(16)).slice(-2);
  }).join('')
}

