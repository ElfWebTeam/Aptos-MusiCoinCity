module ForestContract::ForestContract {
    use aptos_framework::coin::{transfer};
    use aptos_framework::signer;

    struct ForestWallet has key {
        owner: address,
        balance: u64,
    }

    public fun initialize_forest_wallet(owner: &signer) {
        let wallet = ForestWallet {
            owner: signer::address_of(owner),
            balance: 0,
        };
        move_to(owner, wallet);
    }

    public fun add_funds(owner: &signer, amount: u64) acquires ForestWallet {
        let wallet = borrow_global_mut<ForestWallet>(signer::address_of(owner));
        wallet.balance = wallet.balance + amount;
    }

    public fun transfer_to_main_wallet(sender: &signer, amount: u64) acquires ForestWallet {
        let wallet = borrow_global_mut<ForestWallet>(signer::address_of(sender));
        let main_wallet: address = @0xa6356966eb0b3d7cc1ff15a9a5b11026c577ea896609befd6e939fa7c796d8cc;
        transfer<aptos_framework::aptos_coin::AptosCoin>(sender, main_wallet, amount);
    }
}
