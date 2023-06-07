#!/bin/bash

########################################################################################################
# Script:       BLE_Fields_Extract.sh
# Description:  This script utilizes tshark to extract Bluetooth Low Energy (BLE) features from a 
#               PCAP file and outputs them into a CSV format. It helps in analyzing BLE traffic 
#               captured in PCAP files by converting the data into a structured format for further 
#               analysis or processing.
# Authors:      @joseareia, @ivoafonsobispo
# Sed Command:  sed 's/^/-e /; s/$/ \\/' "fields.txt" > "filtered.txt" -> Produces "-e <FIELD> \"
# Filters:      btle, frame, fr, nordic_ble
########################################################################################################

tshark -r $1 -T fields -E header=y -E separator=, -E quote=d -E occurrence=f \
-e btle.access_address \
-e btle.access_address.bit_errors \
-e btle.access_address.illegal \
-e btle.access_address.matched \
-e btle.advertising_address \
-e btle.advertising_header \
-e btle.advertising_header.ch_sel \
-e btle.advertising_header.length \
-e btle.advertising_header.pdu_type \
-e btle.advertising_header.randomized_rx \
-e btle.advertising_header.randomized_tx \
-e btle.advertising_header.rfu.1 \
-e btle.advertising_header.rfu.2 \
-e btle.advertising_header.rfu.3 \
-e btle.advertising_header.rfu.4 \
-e btle.coding_indicator \
-e btle.control.channel_map \
-e btle.control.company_id \
-e btle.control.encrypted_diversifier \
-e btle.control.error_code \
-e btle.control.feature_set \
-e btle.control.feature_set.ch_sel_2 \
-e btle.control.feature_set.connection_parameters_request_procedure \
-e btle.control.feature_set.ext_scan_flt_pol \
-e btle.control.feature_set.extended_reject_indication \
-e btle.control.feature_set.le_2m_phy \
-e btle.control.feature_set.le_coded_phy \
-e btle.control.feature_set.le_encryption \
-e btle.control.feature_set.le_extended_adv \
-e btle.control.feature_set.le_ping \
-e btle.control.feature_set.le_pkt_len_ext \
-e btle.control.feature_set.le_power_class_1 \
-e btle.control.feature_set.le_privacy \
-e btle.control.feature_set.min_num_used_ch_proc \
-e btle.control.feature_set.periodic_adv \
-e btle.control.feature_set.reserved \
-e btle.control.feature_set.reserved_bits \
-e btle.control.feature_set.slave_initiated_features_exchange \
-e btle.control.feature_set.st_mod_idx_rx \
-e btle.control.feature_set.st_mod_idx_tx \
-e btle.control.instant \
-e btle.control.interval \
-e btle.control.interval.max \
-e btle.control.interval.min \
-e btle.control.latency \
-e btle.control.m_to_s_phy \
-e btle.control.master_session_initialization_vector \
-e btle.control.master_session_key_diversifier \
-e btle.control.max_rx_octets \
-e btle.control.max_rx_time \
-e btle.control.max_tx_octets \
-e btle.control.max_tx_time \
-e btle.control.min_used_channels \
-e btle.control.offset.0 \
-e btle.control.offset.1 \
-e btle.control.offset.2 \
-e btle.control.offset.3 \
-e btle.control.offset.4 \
-e btle.control.offset.5 \
-e btle.control.phys \
-e btle.control.phys.le_1m_phy \
-e btle.control.phys.le_2m_phy \
-e btle.control.phys.le_coded_phy \
-e btle.control.phys.reserved \
-e btle.control.preferred_periodicity \
-e btle.control.random_number \
-e btle.control.reference_connection_event_count \
-e btle.control.reject_opcode \
-e btle.control.rx_phys \
-e btle.control.s_to_m_phy \
-e btle.control.slave_session_initialization_vector \
-e btle.control.slave_session_key_diversifier \
-e btle.control.subversion_number \
-e btle.control.timeout \
-e btle.control.tx_phys \
-e btle.control.unknown_type \
-e btle.control.version_number \
-e btle.control.window_offset \
-e btle.control.window_size \
-e btle.control_opcode \
-e btle.crc \
-e btle.crc.incorrect \
-e btle.crc.indeterminate \
-e btle.data_header \
-e btle.data_header.length \
-e btle.data_header.llid \
-e btle.data_header.more_data \
-e btle.data_header.next_expected_sequence_number \
-e btle.data_header.rfu \
-e btle.data_header.sequence_number \
-e btle.ea.host_advertising_data.fragment \
-e btle.ea.host_advertising_data.fragment.count \
-e btle.ea.host_advertising_data.fragment.error \
-e btle.ea.host_advertising_data.fragment.multiple_tails \
-e btle.ea.host_advertising_data.fragment.overlap \
-e btle.ea.host_advertising_data.fragment.overlap.conflicts \
-e btle.ea.host_advertising_data.fragment.too_long_fragment \
-e btle.ea.host_advertising_data.fragments \
-e btle.ea.host_advertising_data.reassembled.in \
-e btle.ea.host_advertising_data.reassembled.length \
-e btle.extended_advertising.advertising_data_info \
-e btle.extended_advertising.advertising_data_info.did \
-e btle.extended_advertising.advertising_data_info.sid \
-e btle.extended_advertising.aux_pointer \
-e btle.extended_advertising.had_fragment \
-e btle.extended_advertising.sync_info \
-e btle.extended_advertising_header \
-e btle.extended_advertising_header.acad \
-e btle.extended_advertising_header.advertiser_data_info \
-e btle.extended_advertising_header.aux_pointer.aux_offset \
-e btle.extended_advertising_header.aux_pointer.aux_phy \
-e btle.extended_advertising_header.aux_pointer.ca \
-e btle.extended_advertising_header.aux_pointer.channel \
-e btle.extended_advertising_header.aux_pointer.offset_units \
-e btle.extended_advertising_header.cte_info \
-e btle.extended_advertising_header.cte_info.rfu \
-e btle.extended_advertising_header.cte_info.time \
-e btle.extended_advertising_header.cte_info.type \
-e btle.extended_advertising_header.flags \
-e btle.extended_advertising_header.flags.advertiser_address \
-e btle.extended_advertising_header.flags.aux_pointer \
-e btle.extended_advertising_header.flags.cte_info \
-e btle.extended_advertising_header.flags.reserved \
-e btle.extended_advertising_header.flags.sync_info \
-e btle.extended_advertising_header.flags.target_address \
-e btle.extended_advertising_header.flags.tx_power \
-e btle.extended_advertising_header.length \
-e btle.extended_advertising_header.mode \
-e btle.extended_advertising_header.sync_info.access_address \
-e btle.extended_advertising_header.sync_info.channel_map \
-e btle.extended_advertising_header.sync_info.crc_init \
-e btle.extended_advertising_header.sync_info.event_counter \
-e btle.extended_advertising_header.sync_info.interval \
-e btle.extended_advertising_header.sync_info.offset_adjust \
-e btle.extended_advertising_header.sync_info.offset_units \
-e btle.extended_advertising_header.sync_info.sleep_clock_accuracy \
-e btle.extended_advertising_header.sync_info.sync_offset \
-e btle.extended_advertising_header.tx_power \
-e btle.initiator_address \
-e btle.l2cap.fragment \
-e btle.l2cap.fragment.count \
-e btle.l2cap.fragment.error \
-e btle.l2cap.fragment.multiple_tails \
-e btle.l2cap.fragment.overlap \
-e btle.l2cap.fragment.overlap.conflicts \
-e btle.l2cap.fragment.too_long_fragment \
-e btle.l2cap.fragments \
-e btle.l2cap.reassembled.in \
-e btle.l2cap.reassembled.length \
-e btle.l2cap_data \
-e btle.l2cap_index \
-e btle.length \
-e btle.link_layer_data \
-e btle.link_layer_data.access_address \
-e btle.link_layer_data.channel_map \
-e btle.link_layer_data.crc_init \
-e btle.link_layer_data.hop \
-e btle.link_layer_data.interval \
-e btle.link_layer_data.latency \
-e btle.link_layer_data.sleep_clock_accuracy \
-e btle.link_layer_data.timeout \
-e btle.link_layer_data.window_offset \
-e btle.link_layer_data.window_size \
-e btle.master_bd_addr \
-e btle.missing_fragment_start \
-e btle.retransmit \
-e btle.scan_responce_data \
-e btle.scanning_address \
-e btle.slave_bd_addr \
-e btle.target_address \
-e frame.cap_len \
-e frame.coloring_rule.name \
-e frame.coloring_rule.string \
-e frame.comment \
-e frame.comment.expert \
-e frame.encap_type \
-e frame.file_off \
-e frame.ignored \
-e frame.incomplete \
-e frame.interface_description \
-e frame.interface_id \
-e frame.interface_name \
-e frame.interface_queue \
-e frame.len \
-e frame.link_nr \
-e frame.marked \
-e frame.md5_hash \
-e frame.number \
-e frame.offset_shift \
-e frame.p2p_dir \
-e frame.packet_flags \
-e frame.packet_flags_crc_error \
-e frame.packet_flags_direction \
-e frame.packet_flags_fcs_length \
-e frame.packet_flags_packet_too_error \
-e frame.packet_flags_packet_too_short_error \
-e frame.packet_flags_preamble_error \
-e frame.packet_flags_reception_type \
-e frame.packet_flags_reserved \
-e frame.packet_flags_start_frame_delimiter_error \
-e frame.packet_flags_symbol_error \
-e frame.packet_flags_unaligned_frame_error \
-e frame.packet_flags_wrong_inter_frame_gap_error \
-e frame.packet_id \
-e frame.protocols \
-e frame.ref_time \
-e frame.time \
-e frame.time_delta \
-e frame.time_delta_displayed \
-e frame.time_epoch \
-e frame.time_invalid \
-e frame.time_relative \
-e frame.verdict \
-e frame.verdict.ebpf_tc \
-e frame.verdict.ebpf_xdp \
-e frame.verdict.hw \
-e fr.becn \
-e fr.bogus_address \
-e fr.chdlctype \
-e fr.control \
-e fr.control.f \
-e fr.control.ftype \
-e fr.control.n_r \
-e fr.control.n_s \
-e fr.control.p \
-e fr.control.s_ftype \
-e fr.control.u_modifier_cmd \
-e fr.control.u_modifier_resp \
-e fr.cr \
-e fr.dc \
-e fr.de \
-e fr.dlci \
-e fr.dlcore_control \
-e fr.ea \
-e fr.fecn \
-e fr.first_addr_octet \
-e fr.frame_relay.lapf \
-e fr.frame_relay.xid \
-e fr.lower_dlci \
-e fr.nlpid \
-e fr.second_addr_octet \
-e fr.second_dlci \
-e fr.snap.oui \
-e fr.snap.pid \
-e fr.snaptype \
-e fr.third_addr_octet \
-e fr.third_dlci \
-e fr.upper_dlci \
-e nordic_ble.address_resolved \
-e nordic_ble.aux_type \
-e nordic_ble.board_id \
-e nordic_ble.channel \
-e nordic_ble.crc.bad \
-e nordic_ble.crcok \
-e nordic_ble.delta_time \
-e nordic_ble.delta_time_ss \
-e nordic_ble.direction \
-e nordic_ble.encrypted \
-e nordic_ble.event_counter \
-e nordic_ble.flag_reserved1 \
-e nordic_ble.flag_reserved2 \
-e nordic_ble.flag_reserved7 \
-e nordic_ble.flags \
-e nordic_ble.header \
-e nordic_ble.hlen \
-e nordic_ble.legacy_marker \
-e nordic_ble.len \
-e nordic_ble.length.bad \
-e nordic_ble.mic.bad \
-e nordic_ble.mic_not_relevant \
-e nordic_ble.micok \
-e nordic_ble.packet_counter \
-e nordic_ble.packet_id \
-e nordic_ble.packet_time \
-e nordic_ble.phy \
-e nordic_ble.plen \
-e nordic_ble.protover \
-e nordic_ble.protover.bad \
-e nordic_ble.rssi \
-e nordic_ble.time \
> CSV/Bluetooth_Low_Energy_Dataset.csv