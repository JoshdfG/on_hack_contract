// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NexusNFT is ERC721 {
    mapping(address => uint256) public no_of_mintedNFTs;

    constructor() ERC721("Nexus NFT", "Nex") {}

    function _baseURI() internal pure override returns (string memory) {
        return
            "https://amaranth-genuine-kangaroo-139.mypinata.cloud/ipfs/Qma3E93qKVEL8bbnAyGtyJUW7iJWuZ1xK7QXubh73eD2nf/";
    }

    function safeMint(address to, uint256 tokenId) public payable {
        require(no_of_mintedNFTs[msg.sender] < 2, "Already minted 2 NFTs");
        no_of_mintedNFTs[msg.sender]++;
        _safeMint(to, tokenId);
    }
}
