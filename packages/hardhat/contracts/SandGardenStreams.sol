pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";

contract SandGardenStreams is Ownable {

    struct BuilderStreamInfo {
        uint256 cap;
        uint256 last;
    }
    mapping(address => BuilderStreamInfo) public streamedBuilders;
    uint256 public frequency = 2592000; // 30 days

    event Withdraw(address indexed to, uint256 amount, string reason);
    event AddBuilder(address indexed to, uint256 amount);
    event UpdateBuilder(address indexed to, uint256 amount);

    constructor() { 
        emit Withdraw(0x38c772B96D73733F425746bd368B4B4435A37967, 1500000000000000000, "Working on BG RPC redesign to use micro service design so that it doesn't turn into spaghetti (committing as user Ubuntu). https://github.com/austintgriffith/geth-node-ssl-proxy/tree/bg-rpc-proxy https://github.com/sfaber34/bg-rpc-logs");
        emit Withdraw(0x38c772B96D73733F425746bd368B4B4435A37967, 1500000000000000000, "BG Client maintenance (https://github.com/BuidlGuidl/buidlguidl-client/tree/staging). BG RPC cleanup, restructure, added a dashboard - preparing to improve RPC functionality (https://github.com/austintgriffith/geth-node-ssl-proxy)");
        emit Withdraw(0x38c772B96D73733F425746bd368B4B4435A37967, 1498400000000000000, "Devcon 7. Maintenance for BG Client (https://github.com/BuidlGuidl/buidlguidl-client). Restructuring RPC code (https://github.com/austintgriffith/geth-node-ssl-proxy/tree/bg-rpc-restructure)");
        emit Withdraw(0x38c772B96D73733F425746bd368B4B4435A37967, 1500000000000000000, "Improving the reliability and restructuring RPC code (https://github.com/austintgriffith/geth-node-ssl-proxy/tree/bg-rpc-restructure). Modifications to BG client to improve rpc logic and added client version control (https://github.com/BuidlGuidl/buidlguidl-client/tree/staging). Hardware work to get ready for devcon.");
        emit Withdraw(0x38c772B96D73733F425746bd368B4B4435A37967, 1000000000000000000, "Improvements on the BG client repo (https://github.com/BuidlGuidl/buidlguidl-client). Backend work to make p2p connections between BG clients.");
        emit Withdraw(0x38c772B96D73733F425746bd368B4B4435A37967, 500000000000000000, "Continued work on BG Client improvements https://github.com/BuidlGuidl/buidlguidl-client");
        emit Withdraw(0x38c772B96D73733F425746bd368B4B4435A37967, 500000000000000000, "More nodes work to get the first alpha shipped https://github.com/BuidlGuidl/buidlguidl-client/releases/tag/v0.2.0-alpha");
        emit Withdraw(0x38c772B96D73733F425746bd368B4B4435A37967, 1000000000000000000, "Continued work on https://github.com/BuidlGuidl/buidlguidl-client and babysitting nodes");

        _transferOwnership(0x11E91FB4793047a68dFff29158387229eA313ffE);
    }

    struct BuilderData {
        address builderAddress;
        uint256 cap;
        uint256 unlockedAmount;
    }

    function allBuildersData(address[] memory _builders) public view returns (BuilderData[] memory) {
        BuilderData[] memory result = new BuilderData[](_builders.length);
        for (uint256 i = 0; i < _builders.length; i++) {
            address builderAddress = _builders[i];
            BuilderStreamInfo storage builderStream = streamedBuilders[builderAddress];
            result[i] = BuilderData(builderAddress, builderStream.cap, unlockedBuilderAmount(builderAddress));
        }
        return result;
    }

    function unlockedBuilderAmount(address _builder) public view returns (uint256) {
        BuilderStreamInfo memory builderStream = streamedBuilders[_builder];
        if (builderStream.cap == 0) {
            return 0;
        }

        if (block.timestamp - builderStream.last > frequency) {
            return builderStream.cap;
        }

        return (builderStream.cap * (block.timestamp - builderStream.last)) / frequency;
    }

    function addBuilderStream(address payable _builder, uint256 _cap) public onlyOwner {
        streamedBuilders[_builder] = BuilderStreamInfo(_cap, block.timestamp - frequency);
        emit AddBuilder(_builder, _cap);
    }

    function addBatch(address[] memory _builders, uint256[] memory _caps) public onlyOwner {
        require(_builders.length == _caps.length, "Lengths are not equal");
        for (uint256 i = 0; i < _builders.length; i++) {
            addBuilderStream(payable(_builders[i]), _caps[i]);
        }
    }

    function updateBuilderStreamCap(address payable _builder, uint256 _cap) public onlyOwner {
        BuilderStreamInfo memory builderStream = streamedBuilders[_builder];
        require(builderStream.cap > 0, "No active stream for builder");
        streamedBuilders[_builder].cap = _cap;
        emit UpdateBuilder(_builder, _cap);
    }

    function streamWithdraw(uint256 _amount, string memory _reason) public {
        require(address(this).balance >= _amount, "Not enough funds in the contract");
        BuilderStreamInfo storage builderStream = streamedBuilders[msg.sender];
        require(builderStream.cap > 0, "No active stream for builder");

        uint256 totalAmountCanWithdraw = unlockedBuilderAmount(msg.sender);
        require(totalAmountCanWithdraw >= _amount,"Not enough in the stream");

        uint256 cappedLast = block.timestamp - frequency;
        if (builderStream.last < cappedLast){
            builderStream.last = cappedLast;
        }

        builderStream.last = builderStream.last + ((block.timestamp - builderStream.last) * _amount / totalAmountCanWithdraw);

        (bool sent,) = msg.sender.call{value: _amount}("");
        require(sent, "Failed to send Ether");

        emit Withdraw(msg.sender, _amount, _reason);
    }

    // to support receiving ETH by default
    receive() external payable {}
    fallback() external payable {}
}
