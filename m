Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A66B1C389C
	for <lists+linux-raid@lfdr.de>; Mon,  4 May 2020 13:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgEDLxF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 4 May 2020 07:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDLxF (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 4 May 2020 07:53:05 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2651C061A0E
        for <linux-raid@vger.kernel.org>; Mon,  4 May 2020 04:53:04 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jVZeg-00050z-6D; Mon, 04 May 2020 13:53:02 +0200
Subject: Re: RAID 1 | Restore based on Image of /dev/sda
To:     Johannes Truschnigg <johannes@truschnigg.info>
Cc:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org
References: <5e29b897-b2df-c6b9-019a-e037101bfeec@peter-speer.de>
 <5EAFF763.2000906@youngman.org.uk>
 <58659d1e-bcce-553c-fe68-52d075422252@peter-speer.de>
 <20200504113652.GA22487@vault.lan>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <fe7f04ef-0dfe-8c89-0b4d-cc3d6bebcffe@peter-speer.de>
Date:   Mon, 4 May 2020 13:52:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504113652.GA22487@vault.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1588593184;cd36fd4e;
X-HE-SMSGID: 1jVZeg-00050z-6D
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 04.05.20 13:36, Johannes Truschnigg wrote:
> Hi Steffi,
> 
> On Mon, May 04, 2020 at 01:26:35PM +0200, Stefanie Leisestreichler wrote:
>> [...]
>> Thanks, Wol, especially for the hint with the GUIDs, will keep this in mind.
>> If ever using it again - maybe in case of a quick temporary replacement in
>> the original computer - I will wipe it with zeros before.
>>
>> The partition layout will be cloned using sfdisk.
> 
> When dealing with GPT partitions, you might want to consider using `sgdisk`
> instead. It features -G|--randomize-guids and will be able to clone a GPT
> table from one drive to another in one go, without you having to iron out
> UUID-related problems that "naive" cloning (which I believe `sfdisk` will
> perform) will introduce.
> 
> Hth!
> 

This also found its way in my private wiki, thanks!
