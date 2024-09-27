// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

contract CapybaraNFT is ERC1155, Ownable, ERC1155Burnable {
    uint256 private _nextTokenId;

    constructor(
        address initialOwner,
        string memory newuri
    ) ERC1155(newuri) Ownable(initialOwner) {
        _nextTokenId = 1;
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(address account, bytes memory data) public onlyOwner {
        uint256 tokenId = _nextTokenId;
        _mint(account, tokenId, 1, data);
        _nextTokenId += 1;
    }

    function mintBatch(
        address to,
        uint256 count,
        bytes memory data
    ) public onlyOwner {
        for (uint256 i = 0; i < count; i++) {
            mint(to, data);
        }
    }

}
