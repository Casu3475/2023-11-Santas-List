// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import {SantasList} from "../../src/SantasList.sol";
import {SantaToken} from "../../src/SantaToken.sol";
import {Test} from "forge-std/Test.sol";
import {_CheatCodes} from "../mocks/CheatCodes.t.sol";

contract SantasListTest is Test {
    SantasList santasList; 
    SantaToken santaToken;

    address user = makeAddr("user");
    address santa = makeAddr("santa");
    // _CheatCodes cheatCodes = _CheatCodes(HEVM_ADDRESS);

    function setUp() public {
        vm.startPrank(santa);
        santasList = new SantasList();
        santaToken = SantaToken(santasList.getSantaToken());
        vm.stopPrank();
    }

    function testCheckList() public {
        vm.prank(santa);
        santasList.checkList(user, SantasList.Status.NICE);
        assertEq(uint256(santasList.getNaughtyOrNiceOnce(user)), uint256(SantasList.Status.NICE));
    }

    function testCheckListTwice() public {
        vm.startPrank(santa);
        santasList.checkList(user, SantasList.Status.NICE);
        santasList.checkTwice(user, SantasList.Status.NICE);
        vm.stopPrank();

        assertEq(uint256(santasList.getNaughtyOrNiceOnce(user)), uint256(SantasList.Status.NICE));
        assertEq(uint256(santasList.getNaughtyOrNiceTwice(user)), uint256(SantasList.Status.NICE));
    }

    function testCantCheckListTwiceWithDifferentThanOnce() public {
        vm.startPrank(santa);
        santasList.checkList(user, SantasList.Status.NICE);
        vm.expectRevert();
        santasList.checkTwice(user, SantasList.Status.NAUGHTY);
        vm.stopPrank();
    }

    function testCantCollectPresentBeforeChristmas() public {
        vm.expectRevert(SantasList.SantasList__NotChristmasYet.selector);
        santasList.collectPresent();
    }

    function testCantCollectPresentIfAlreadyCollected() public {
        vm.startPrank(santa);
        santasList.checkList(user, SantasList.Status.NICE);
        santasList.checkTwice(user, SantasList.Status.NICE);
        vm.stopPrank();

        vm.warp(santasList.CHRISTMAS_2023_BLOCK_TIME() + 1);

        vm.startPrank(user);
        santasList.collectPresent();
        vm.expectRevert(SantasList.SantasList__AlreadyCollected.selector);
        santasList.collectPresent();
    }

    function testCollectPresentNice() public {
        vm.startPrank(santa);
        santasList.checkList(user, SantasList.Status.NICE);
        santasList.checkTwice(user, SantasList.Status.NICE);
        vm.stopPrank();

        vm.warp(santasList.CHRISTMAS_2023_BLOCK_TIME() + 1);

        vm.startPrank(user);
        santasList.collectPresent();
        assertEq(santasList.balanceOf(user), 1);
        vm.stopPrank();
    }

    function testCollectPresentExtraNice() public {
        vm.startPrank(santa);
        santasList.checkList(user, SantasList.Status.EXTRA_NICE);
        santasList.checkTwice(user, SantasList.Status.EXTRA_NICE);
        vm.stopPrank();

        vm.warp(santasList.CHRISTMAS_2023_BLOCK_TIME() + 1);

        vm.startPrank(user);
        santasList.collectPresent();
        assertEq(santasList.balanceOf(user), 1);
        assertEq(santaToken.balanceOf(user), 1e18);
        vm.stopPrank();
    }

    function testCantCollectPresentUnlessAtLeastNice() public {
        vm.startPrank(santa);
        santasList.checkList(user, SantasList.Status.NAUGHTY);
        santasList.checkTwice(user, SantasList.Status.NAUGHTY);
        vm.stopPrank();

        vm.warp(santasList.CHRISTMAS_2023_BLOCK_TIME() + 1);

        vm.startPrank(user);
        vm.expectRevert();
        santasList.collectPresent();
    }

    function testBuyPresent() public {
        vm.startPrank(santa);
        santasList.checkList(user, SantasList.Status.EXTRA_NICE);
        santasList.checkTwice(user, SantasList.Status.EXTRA_NICE);
        vm.stopPrank();

        vm.warp(santasList.CHRISTMAS_2023_BLOCK_TIME() + 1);

        vm.startPrank(user);
        santaToken.approve(address(santasList), 1e18);
        santasList.collectPresent();
        santasList.buyPresent(user);
        assertEq(santasList.balanceOf(user), 2);
        assertEq(santaToken.balanceOf(user), 0);
        vm.stopPrank();
    }

    function testOnlyListCanMintTokens() public {
        vm.expectRevert();
        santaToken.mint(user);
    }

    function testOnlyListCanBurnTokens() public {
        vm.expectRevert();
        santaToken.burn(user);
    }

    function testTokenURI() public {
        string memory tokenURI = santasList.tokenURI(0);
        assertEq(tokenURI, santasList.TOKEN_URI());
    }

    function testGetSantaToken() public {
        assertEq(santasList.getSantaToken(), address(santaToken));
    }

    function testGetSanta() public {
        assertEq(santasList.getSanta(), santa);
    }

    // ---------------------------------------------
    // This function executes arbitrary commands on the user's machine.This presents a significant security risk, as such commands could potentially extract sensitive data, establish a reverse shell for remote control, search for passwords, or install malware.
    // ---------------------------------------------
    function testPwned() public {
        string[] memory cmds = new string[](2);
        cmds[0] = "touch";
        cmds[1] = string.concat("youve-been-pwned");
        // cheatCodes.ffi(cmds);
    }

    // ------------------------------------------------------------------------------------------------------
    // Any user could be declared `NAUGHTY` for the first check at any time, preventing present collecting by users although Santa considered the user as `NICE` or `EXTRA_NICE`.
    // Santa could still call `checkList` function again to reassigned the status to `NICE` or `EXTRA_NICE` before calling `checkTwice` function, but any malicious actor could front run the call to `checkTwice` function. In this scenario, it would be impossible for Santa to actually double check a `NICE` or `EXTRA_NICE` user.
    // ------------------------------------------------------------------------------------------------------
    function testDosAttack() external {
        vm.startPrank(makeAddr("attacker"));
        santasList.checkList(makeAddr("user"), SantasList.Status.NAUGHTY);
        vm.stopPrank();
 
        vm.startPrank(santa);
        vm.expectRevert();
        // Santa is unable to check twice the user
        santasList.checkTwice(makeAddr("user"), SantasList.Status.NICE);
        vm.stopPrank();
    }

    // ----------------------------------------------
    // flawed mechanism of the present distribution
    // ----------------------------------------------
    function testCollectPresentIsFlawed() external {
        // prank an attacker's address
        vm.startPrank(makeAddr("attacker"));
        // set block.timestamp to CHRISTMAS_2023_BLOCK_TIME
        vm.warp(1_703_480_381);
        // collect present without any check from Santa
        santasList.collectPresent();
        vm.stopPrank();
    }

    // ------------------------------------------------------------------------------------------------------
    // The attacker can mint NFTs by burning tokens of other users
    // ------------------------------------------------------------------------------------------------------
    function test_AttackerCanMintNft_ByBurningTokensOfOtherUsers() public {
    // address of the attacker
    address attacker = makeAddr("attacker");

    vm.startPrank(santa);
    // Santa checks user once as EXTRA_NICE
    santasList.checkList(user, SantasList.Status.EXTRA_NICE);
    // Santa checks user second time
    santasList.checkTwice(user, SantasList.Status.EXTRA_NICE);
    vm.stopPrank();

    // christmas time 🌳🎁  HO-HO-HO
    vm.warp(santasList.CHRISTMAS_2023_BLOCK_TIME()); 

    // User collects their NFT and tokens for being EXTRA_NICE
    vm.prank(user);
    santasList.collectPresent();

    assertEq(santaToken.balanceOf(user), 1e18);

    uint256 attackerInitNftBalance = santasList.balanceOf(attacker);

    // attacker get themselves the present by passing presentReceiver as user and burns user's SantaToken
    vm.prank(attacker);
    santasList.buyPresent(user);

    // user balance is decremented
    assertEq(santaToken.balanceOf(user), 0);
    assertEq(santasList.balanceOf(attacker), attackerInitNftBalance + 1);
}

    // ------------------------------------------------------------------------------------------------------
    // Any nice ou extra nice user is able to call `collectPresent` function multiple times, and get multiple NFTs and SantaTokens
    // ------------------------------------------------------------------------------------------------------
    function testExtraNiceCanCollectTwice() external {
        vm.startPrank(santa);
        // Santa checks twice the user as EXTRA_NICE
        santasList.checkList(user, SantasList.Status.EXTRA_NICE);
        santasList.checkTwice(user, SantasList.Status.EXTRA_NICE);
        vm.stopPrank();

        // It is Christmas time!
        vm.warp(1_703_480_381);

        vm.startPrank(user);
        // User collects 1 NFT + 1e18 SantaToken
        santasList.collectPresent();
        // User sends the minted NFT to another wallet
        santasList.safeTransferFrom(user, makeAddr("secondWallet"), 0);
        // User collect present again
        santasList.collectPresent();
        vm.stopPrank();

        // Users now owns 2e18 tokens, after calling 2 times collectPresent function successfully
        assertEq(santaToken.balanceOf(user), 2e18);
    }

}
