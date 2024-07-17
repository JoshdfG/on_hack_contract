// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NexusNFT is ERC721 {
    mapping(address => uint256) public no_of_mintedNFTs;
    address public deployer;

    constructor() ERC721("NexusNFT", "Nex") {
        deployer = msg.sender;
    }

    function _baseURI() internal pure override returns (string memory) {
        return
            "https://amaranth-genuine-kangaroo-139.mypinata.cloud/ipfs/QmQ4VoEGnT51XViT3o3WEzchpKmeax7ngE4YtVnmEJUMq4/";
    }

    function safeMint(address to, uint256 tokenId) public payable {
        if (msg.sender == deployer) {
            _safeMint(to, tokenId);
        } else {
            require(no_of_mintedNFTs[msg.sender] <= 2, "Already minted 2 NFTs");
            no_of_mintedNFTs[msg.sender]++;
            _safeMint(to, tokenId);
        }
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4) {
        return this.onERC721Received.selector;
    }
}
