use snforge_std::{declare, load, map_entry_address, ContractClassTrait, DeclareResultTrait};

use core::traits::TryInto;
use core::serde::Serde;
use starknet::ContractAddress;
use openzeppelin::token::erc721::interface::{IERC721Dispatcher, IERC721DispatcherTrait};
use starknet_auction::starknet_auction::IStarknetAuctionDispatcher;
use starknet_auction::starknet_auction::IStarknetAuctionDispatcherTrait;
use starknet_auction::mock_erc20_token::IMockERC20TokenDispatcher;
use starknet_auction::mock_erc20_token::IMockERC20TokenDispatcherTrait;
use starknet::{get_caller_address, get_contract_address, get_block_timestamp};

fn deploy_auction_contract() -> (
    IStarknetAuctionDispatcher, ContractAddress, ContractAddress, ContractAddress
) {
    // Declare Starknet Auction contract.
    let contract = declare("StarknetAuction").unwrap().contract_class();
    // Define arguments.
    let mut calldata = ArrayTrait::new();

    // Declare and deploy the NFT token contract.
    let erc721_contract = declare("MockERC721Token").unwrap().contract_class();
    let mut erc721_args = ArrayTrait::new();
    let recipient = get_contract_address();
    (recipient,).serialize(ref erc721_args);
    let (erc721_contract_address, _) = erc721_contract.deploy(@erc721_args).unwrap();

    // Declare and deploy the ERC20 token contract
    let erc20_contract = declare("MockERC20Token").unwrap().contract_class();
    let mut erc20_args = ArrayTrait::new();
    let (erc20_contract_address, _) = erc20_contract.deploy(@erc20_args).unwrap();

    let nft_id = 1;
    (erc20_contract_address, erc721_contract_address, nft_id,).serialize(ref calldata);
    // Deploy the Auction contract 
    let (contract_address, _) = contract.deploy(@calldata).unwrap();

    // Create a Dispatcher object that will allow interacting with the deployed Auction contract
    let dispatcher = IStarknetAuctionDispatcher { contract_address: contract_address };
    // Create a Dispatcher object that will allow interacting with the deployed NFT contract
    let erc721_dispatcher = IERC721Dispatcher { contract_address: erc721_contract_address };
    erc721_dispatcher.approve(contract_address, 1);

    (dispatcher, contract_address, erc20_contract_address, erc721_contract_address)
}

#[test]
fn test_deployment() {
    let (auction_dispatcher, auction_contract, _, _) = deploy_auction_contract();
    print!("hi");
    // let nft_id = load(auction_contract, selector!("nft_id"), 1);
    print!("hi-1");
    // assert(nft_id == array![1], 'nft_id == 1');
}
