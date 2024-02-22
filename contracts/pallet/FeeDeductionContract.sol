// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FeeDeductionContract is Ownable {
    uint256 public feeAmount = 100000000000000; //0.0001

    event Withdrawal(bool state, uint256 amount, address target);

    event SubmitData(bytes data, address target);

    constructor(address initialOwner) Ownable(initialOwner) {}

    // Allows the owner to change the fee amount
    function setFeeAmount(uint256 _newFeeAmount) external onlyOwner {
        feeAmount = _newFeeAmount;
    }

    //https://domo-2.gitbook.io/brc-20-experiment/
    //{ "p": "brc-20", "op": "deploy", "tick": "ordi", "max": "21000000", "lim": "1000","dec":""}
    //{ "p": "brc-20", "op": "mint", "tick": "ordi", "amt": "1000" }​
    //{ "p": "brc-20", "op": "transfer", "tick": "ordi", "amt": "100"}
    //{"p":"sns","op":"reg","name":"1234.unisat"}​

    function submitData(
        bytes memory data,
        address payable target
    ) public payable {
        require(msg.value >= feeAmount, "Insufficient funds");

        (bool success, ) = payable(address(target)).call{value: 0}(data);

        emit SubmitData(data, target);

        require(success, "Transfer failed.");
    }

    function submitDataWithToken(
        bytes memory data,
        address payable target
    ) public payable {
        require(msg.value >= feeAmount, "Insufficient funds");

        (bool success, ) = payable(address(target)).call{value: 0}(data);

        emit SubmitData(data, target);

        require(success, "Transfer failed.");
    }

    function withdraw(
        address payable target,
        uint256 amount
    ) external onlyOwner {
        if (amount >= address(this).balance) amount = address(this).balance;
        // target.transfer(amount);
        (bool success, ) = address(target).call{value: amount}("");

        emit Withdrawal(success, amount, target);
        require(success, "Transfer failed.");
    }

    function withdrawAll(address payable target) external onlyOwner {
        uint256 value = address(this).balance;
        (bool success, ) = address(target).call{value: value}("");
        emit Withdrawal(success, value, target);
        require(success, "Transfer failed.");
    }
}
