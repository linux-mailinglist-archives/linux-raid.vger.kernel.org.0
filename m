Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 062DBE17B5
	for <lists+linux-raid@lfdr.de>; Wed, 23 Oct 2019 12:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403804AbfJWKWA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 23 Oct 2019 06:22:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:55546 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390361AbfJWKV7 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 23 Oct 2019 06:21:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 03:21:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="223137155"
Received: from apaszkie-desk.igk.intel.com (HELO [10.102.102.225]) ([10.102.102.225])
  by fmsmga004.fm.intel.com with ESMTP; 23 Oct 2019 03:21:58 -0700
Subject: Re: How to assemble Intel RST Matrix volumes?
To:     hhardly@secmail.pro
Cc:     linux-raid@vger.kernel.org
References: <0a32d9235127ec7760334c3308ee6384.squirrel@giyzk7o6dcunb2ry.onion>
 <aff61b6a-15e1-555a-e507-f8dcfcfd3135@intel.com>
 <436ad5949675c156e4062fb23e27c482.squirrel@giyzk7o6dcunb2ry.onion>
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Message-ID: <5fdd5c39-5018-aff6-e0f8-7c2eb5f08c2d@intel.com>
Date:   Wed, 23 Oct 2019 12:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <436ad5949675c156e4062fb23e27c482.squirrel@giyzk7o6dcunb2ry.onion>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 10/22/19 10:51 PM, hhardly@secmail.pro wrote:
> Here is the output you asked for, which shows does show the volumes. Any
> further assistance is greatly appreciated.

I hadn't noticed earlier that you are using copies of the original disks. The
issue with this is that the disks' serial numbers are stored in the metadata.
You can see that in the output from "mdadm -E". Mdadm doesn't recognize a disk
as an array member if its serial number does not match with what is in the
metadata.

Can you use the original disk to assemble the array and keep the copy as
backup? Then you can rebuild the array and later replace this disk with another
one if you want.
