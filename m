Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D4A6F94F4
	for <lists+linux-raid@lfdr.de>; Sun,  7 May 2023 01:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjEFX3D (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 6 May 2023 19:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjEFX3C (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 6 May 2023 19:29:02 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0384713284
        for <linux-raid@vger.kernel.org>; Sat,  6 May 2023 16:28:38 -0700 (PDT)
Received: from host86-157-72-252.range86-157.btcentralplus.com ([86.157.72.252] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1pvRKL-0001mU-B1;
        Sun, 07 May 2023 00:28:33 +0100
Message-ID: <0b5a2849-90ec-573c-03ed-0847135a4e9d@youngman.org.uk>
Date:   Sun, 7 May 2023 00:28:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Second of 3 drives in RAID5 missing
Content-Language: en-GB
To:     Hannes Reinecke <hare@suse.de>, Alex Elder <elder@ieee.org>,
        linux-raid@vger.kernel.org
References: <d11acbac-a31b-b38c-8e10-b664ec52a47b@ieee.org>
 <7605c54f-670a-a804-b238-627cd561ce52@suse.de>
From:   Wol <antlists@youngman.org.uk>
In-Reply-To: <7605c54f-670a-a804-b238-627cd561ce52@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 06/05/2023 23:29, Hannes Reinecke wrote:
>>     Device Role : Active device 2
>>     Array State : AAA ('A' == active, '.' == missing, 'R' == replacing)
>> root@meat:/#
>>
> mdadm manage /dev/md127 --add /dev/sdd ?

OMG NO!

That really will trash your array ...

Cheers,
Wol
