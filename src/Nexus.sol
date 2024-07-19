// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract NexusNFT is ERC1155 {
    string public name;
    string public symbol;
    mapping(address => uint256) public no_of_mintedNFTs;
    address public deployer;

    constructor(
        string memory _name,
        string memory _symbol
    )
        ERC1155(
            "https://amaranth-genuine-kangaroo-139.mypinata.cloud/ipfs/QmQ4VoEGnT51XViT3o3WEzchpKmeax7ngE4YtVnmEJUMq4/"
        )
    {
        deployer = msg.sender;
        name = _name;
        symbol = _symbol;
    }

    function safeMint(
        address to,
        uint256 tokenId,
        uint256 amount
    ) public payable {
        if (msg.sender == deployer) {
            _mint(to, tokenId, amount, "");
        } else {
            require(no_of_mintedNFTs[msg.sender] <= 2, "Already minted 2 NFTs");
            no_of_mintedNFTs[msg.sender]++;
            _mint(to, tokenId, amount, "");
        }
    }

    function onERC1155Received(
        address operator,
        address from,
        uint256 tokenId,
        uint256 amount,
        bytes calldata data
    ) external returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata tokenIds,
        uint256[] calldata amounts,
        bytes calldata data
    ) external returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }
}
