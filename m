Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829311D8810
	for <lists+linux-raid@lfdr.de>; Mon, 18 May 2020 21:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgERTRL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 15:17:11 -0400
Received: from atl.turmel.org ([74.117.157.138]:50326 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgERTRK (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 18 May 2020 15:17:10 -0400
Received: from [45.56.119.232] (helo=[192.168.17.3])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jalG8-00069S-UI; Mon, 18 May 2020 15:17:09 -0400
Subject: Re: RAID wiped superblock recovery
To:     Sam Hurst <sam@sam-hurst.co.uk>, linux-raid@vger.kernel.org
References: <922713c5-0cc1-24cb-14a6-9de7db631f98@sam-hurst.co.uk>
 <0f954924-e7ae-c81e-55f1-afc41e293a18@turmel.org>
 <05011140-3625-5326-96c9-e995f93260f4@sam-hurst.co.uk>
 <e7644f86-5342-b7bb-b6de-b37afd74f6cc@turmel.org>
 <f88bfa57-8a17-eaa1-a926-33e2eb6ddb34@sam-hurst.co.uk>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <deb68974-3faf-fb65-38e2-429762b7418e@turmel.org>
Date:   Mon, 18 May 2020 15:17:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f88bfa57-8a17-eaa1-a926-33e2eb6ddb34@sam-hurst.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Sam,

On 5/18/20 2:52 PM, Sam Hurst wrote:
> Hi Phil,

> I had no idea that you could use sectors as a suffix to data-offset as 
> it's not in the manpage. So you should find attached a patch file which 
> adds that suffix to the manpage. If this isn't the correct place to 
> provide patches, or if there's an issue with the formatting of my patch, 
> please let me know and I'll happily update it and send it to the correct 
> place.

This is the right place.  Patches are wonderful, but do need to be 
formatted to keep the Linux Foundation's lawyers happy.

The best way is to clone the mdadm tree, apply your patch, and commit it 
with a proper identity in your git configuration.  Use the --signoff 
option[1] of git commit.  Then use git format-patch to produce the final 
patch file with the commit details.  Send this final form to the mailing 
list as your mail body (not attachment).  Be sure your mail client is in 
text mode with no line wrapping.

/:

Phil

[1] 
https://stackoverflow.com/questions/1962094/what-is-the-sign-off-feature-in-git-for
