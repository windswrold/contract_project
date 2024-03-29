// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PaymentContract is Ownable {
    IERC20 public ptt;
    IERC20 public usdt;

    event DepositState(
        uint256 uid,
        bool state,
        uint256 amount,
        IERC20 token,
        address to
    );

    constructor(
        address initialOwner,
        address newPtt,
        address newUSDT
    ) Ownable(initialOwner) {
        _setPTT(newPtt);
        _setUSDT(newUSDT);
    }

    function depositUSDT(uint256 uid, address target) external {
        bool state = IERC20(ptt).transferFrom(msg.sender, target, 1 ether);
        emit DepositState(uid, state, 1 ether, usdt, target);
        require(state, "Transfer failed.");
    }

    function depositPTT(uint256 uid, uint256 amount, address target) external {
        bool state = IERC20(usdt).transferFrom(msg.sender, target, amount);
        emit DepositState(uid, state, amount, usdt, target);
        require(state, "Transfer failed.");
    }

    function setPTT(address newPTT) external onlyOwner {
        _setPTT(newPTT);
    }

    function setUSDT(address newUSDT) external onlyOwner {
        _setUSDT(newUSDT);
    }

    function _setPTT(address newPTT) private {
        ptt = IERC20(newPTT);
    }

    function _setUSDT(address newUSDT) private {
        usdt = IERC20(newUSDT);
    }
}
