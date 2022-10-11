# 0.019
# 190000000000000000
from brownie import Lottery, accounts, config
from web3 import Web3
import brownie.network as network


def test_get_enterance_fee():
  account = accounts[0]
  lottery = Lottery.deploy(config["networks"][network.show_active()]["eth_usd_price_feed"], 
  {"from":account},
  )
  assert lottery.getEnteranceFee() > Web3.toWei(0.018, "ether");
  assert lottery.getEnteranceFee() > Web3.toWei(0.022, "ether");
