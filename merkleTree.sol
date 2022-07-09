// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MerkleTree is Ownable{
    // --- PROPERTIES ---- //

    // Calculated from `merkle_tree.js`
    bytes32 public merkleRoot;
    bool public worked = false;

    // --- Constructor -- //
    constructor(bytes32 _merkleRoot) {    
        merkleRoot = _merkleRoot;    
    }

    // --- FUNCTIONS ---- //
    function testMerkle(bytes32[] calldata _merkleProof) public {
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(MerkleProof.verify(_merkleProof, merkleRoot, leaf), "Invalid Merkle Proof.");
        worked = true;
    }

    function setMerkle(bytes32 _merkleRoot) public onlyOwner {
        merkleRoot = _merkleRoot;
    }
}