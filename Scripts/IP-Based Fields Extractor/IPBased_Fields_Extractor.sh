#!/bin/bash

########################################################################################################
# Script:       IPBased_Fields_Extractor.sh
# Description:  This script utilizes tshark to extract IP-Based features from a PCAP file and outputs
#               them into a CSV format. It helps in analyzing IP traffic captured in PCAP files by 
#               converting the data into a structured format for further analysis or processing.
# Authors:      @joseareia, @ivoafonsobispo
# Cut Command:  cut -f 1 fields.txt
# Sed Command:  sed 's/^/-e /; s/$/ \\/' "fields.txt" > "filtered.txt" -> Produces "-e <FIELD> \"
# Filters:      mqtt, frame, ip, tcp, udp, data, coap, arp, http
########################################################################################################

tshark -r $1 -T fields -E header=y -E separator=, -E quote=d -E occurrence=f \
-e tcp.ack \
-e tcp.ack_raw \
-e tcp.analysis \
-e tcp.analysis.ack_lost_segment \
-e tcp.analysis.ack_rtt \
-e tcp.analysis.acks_frame \
-e tcp.analysis.bytes_in_flight \
-e tcp.analysis.flags \
-e tcp.analysis.initial_rtt \
-e tcp.analysis.keep_alive \
-e tcp.analysis.keep_alive_ack \
-e tcp.analysis.lost_segment \
-e tcp.analysis.push_bytes_sent \
-e tcp.analysis.reused_ports \
-e tcp.analysis.window_full \
-e tcp.checksum \
-e tcp.checksum.status \
-e tcp.connection.fin \
-e tcp.connection.rst \
-e tcp.connection.syn \
-e tcp.connection.synack \
-e tcp.dstport \
-e tcp.flags \
-e tcp.flags.ack \
-e tcp.flags.cwr \
-e tcp.flags.ecn \
-e tcp.flags.fin \
-e tcp.flags.ns \
-e tcp.flags.push \
-e tcp.flags.res \
-e tcp.flags.reset \
-e tcp.flags.str \
-e tcp.flags.syn \
-e tcp.flags.urg \
-e tcp.hdr_len \
-e tcp.len \
-e tcp.nxtseq \
-e tcp.option_kind \
-e tcp.option_len \
-e tcp.options \
-e tcp.options.mss \
-e tcp.options.mss_val \
-e tcp.options.sack_perm \
-e tcp.options.timestamp.tsecr \
-e tcp.options.timestamp.tsval \
-e tcp.options.wscale \
-e tcp.options.wscale.multiplier \
-e tcp.options.wscale.shift \
-e tcp.payload \
-e tcp.pdu.size \
-e tcp.port \
-e tcp.reassembled.data \
-e tcp.reassembled.length \
-e tcp.segment \
-e tcp.segment.count \
-e tcp.segment_data \
-e tcp.segments \
-e tcp.seq \
-e tcp.seq_raw \
-e tcp.srcport \
-e tcp.stream \
-e tcp.time_delta \
-e tcp.time_relative \
-e tcp.urgent_pointer \
-e tcp.window_size \
-e ip.addr \
-e ip.checksum \
-e ip.checksum.status \
-e ip.dsfield \
-e ip.dsfield.dscp \
-e ip.dsfield.ecn \
-e ip.dst \
-e ip.dst_host \
-e ip.flags \
-e ip.flags.df \
-e ip.flags.mf \
-e ip.flags.rb \
-e ip.frag_offset \
-e ip.hdr_len \
-e ip.host \
-e ip.id \
-e ip.len \
-e ip.proto \
-e ip.src \
-e ip.src_host \
-e ip.ttl \
-e ip.ttl.lncb \
-e frame.cap_len \
-e frame.encap_type \
-e frame.ignored \
-e frame.interface_id \
-e frame.interface_name \
-e frame.len \
-e frame.marked \
-e frame.number \
-e frame.offset_shift \
-e frame.protocols \
-e frame.time \
-e frame.time_delta \
-e frame.time_delta_displayed \
-e frame.time_epoch \
-e frame.time_relative \
-c 500000 > CSV/Netscan.csv