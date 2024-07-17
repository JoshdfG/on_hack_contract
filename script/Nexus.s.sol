// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Nexus.sol";

contract DeployNexusNFT is Script {
    NexusNFT _nexusNFT;

    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = 0x84b5545E9Bdc62A65bB2353a4cC112e3C6f3ae96;
        vm.startBroadcast(deployerPrivateKey);
        _nexusNFT = new NexusNFT();
        _nexusNFT.safeMint(deployer, 0);
        _nexusNFT.safeMint(deployer, 1);
        vm.stopBroadcast();
        writeAddressesToFile(address(_nexusNFT), "MetaNFT Address");
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4) {
        return this.onERC721Received.selector;
    }

    function writeAddressesToFile(address addr, string memory text) public {
        string memory filename = "./deployed_contracts.txt";

        vm.writeLine(
            filename,
            "-------------------------------------------------"
        );
        vm.writeLine(filename, text);
        vm.writeLine(filename, vm.toString(addr));
        vm.writeLine(
            filename,
            "-------------------------------------------------"
        );
    }
}
