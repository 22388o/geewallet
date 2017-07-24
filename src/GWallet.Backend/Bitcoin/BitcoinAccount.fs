﻿namespace GWallet.Backend.Bitcoin

open System

open GWallet.Backend

module internal Account =

    // TODO: return MaybeCached<decimal>
    let GetBalance(account: IAccount): decimal =
        let electrumServer = ElectrumServer.PickRandom()
        use electrumClient = new ElectrumClient(electrumServer)
        electrumClient.GetBalance account.PublicAddress |> UnitConversion.FromSatoshiToBTC

    let ValidateAddress (address: string) =
        let BITCOIN_ADDRESSES_LENGTH = 34
        let BITCOIN_ADDRESS_PREFIX = "1"

        if not (address.StartsWith(BITCOIN_ADDRESS_PREFIX)) then
            raise (AddressMissingProperPrefix(BITCOIN_ADDRESS_PREFIX))

        if (address.Length <> BITCOIN_ADDRESSES_LENGTH) then
            raise (AddressWithInvalidLength(BITCOIN_ADDRESSES_LENGTH))

        // FIXME: add bitcoin checksum algorithm?
