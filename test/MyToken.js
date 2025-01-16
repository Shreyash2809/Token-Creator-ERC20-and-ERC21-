const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TokenFactory and ERC20Token", function () {
  let TokenFactory, factory, owner;

  beforeEach(async function () {
    // Deploy TokenFactory contract
    TokenFactory = await ethers.getContractFactory("TokenFactory");
    [owner] = await ethers.getSigners();
    factory = await TokenFactory.deploy();
    await factory.deployed();
  });

  it("should create a new token with correct parameters", async function () {
    // Define token parameters
    const name = "TestToken";
    const symbol = "TTK";
    const initialSupply = ethers.utils.parseUnits("1000", 18); // 1000 tokens
    const decimals = 18;
    const price = ethers.utils.parseEther("0.01"); // 0.01 ETH per token

    // Call createToken function
    const tx = await factory.createToken(name, symbol, initialSupply, decimals, price);
    const receipt = await tx.wait();

    // Extract TokenCreated event
    const event = receipt.events.find((e) => e.event === "TokenCreated");
    const { tokenAddress } = event.args;

    // Attach to the newly created ERC20Token contract
    const ERC20Token = await ethers.getContractFactory("ERC20Token");
    const token = await ERC20Token.attach(tokenAddress);

    // Verify token properties
    expect(await token.name()).to.equal(name);
    expect(await token.symbol()).to.equal(symbol);
    expect(await token.decimals()).to.equal(decimals);
    expect(await token.tokenPrice()).to.equal(price);
    expect(await token.balanceOf(owner.address)).to.equal(initialSupply);
  });
});
