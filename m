Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551216FCCBA
	for <lists+linux-raid@lfdr.de>; Tue,  9 May 2023 19:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjEIR1w (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 May 2023 13:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjEIR1v (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 9 May 2023 13:27:51 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1623E1BE6
        for <linux-raid@vger.kernel.org>; Tue,  9 May 2023 10:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683653259; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=eRn5TG+iDu5CA7F01RfVicZHOV87r4Mv+CphMPFW36LWrl++RD8gXFWO5Xv3OeiciPLBll/8P2frQcHkYo2euVKQC7a9JQCOtOcjItpVaaoLa8qCEP46xGh1Hr/RqY/Phuf4kNNlq0MnLbVCJwuweFP1Zb2iBU+YpU62J40LTAI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1683653259; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ETfBYGyX04fsmKaor6v6WUKDCFZShJ//PqH8HZbWa/k=; 
        b=kDPW8dnZUmUo0CCI46Gp3KiWwUITKYqxb96gxUlT0EiKUCpeDTphwHeTxuadC/Dkr6YfDeTO0Q4pSzh4P/0ukL/ZHR7IXu/uJlCcEvi1oTDVt7sf9MWkygTczmr7VSqnoGmjEuy9xIlGEQmbIEPB5vUO8DX+rsES2KnD7TqLNfw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [IPV6:2620:10d:c0a8:1102::1004] (163.114.130.3 [163.114.130.3]) by mx.zoho.eu
        with SMTPS id 1683653256609375.2922068755561; Tue, 9 May 2023 19:27:36 +0200 (CEST)
Message-ID: <b66f7005-754a-2f4c-f750-a9a62835ddfe@trained-monkey.org>
Date:   Tue, 9 May 2023 13:27:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: mdadm minimum kernel version requirements?
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     "Kernel.org-Linux-RAID" <linux-raid@vger.kernel.org>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
References: <e8ed86bb-4162-7d8e-ece9-eb75e045bcc5@trained-monkey.org>
 <168116364433.24821.9557577764628245206@noble.neil.brown.name>
 <9bfd76c4-3775-4ba6-10c3-ac32b5389f63@trained-monkey.org>
 <168357984365.26026.8909042734026812929@noble.neil.brown.name>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <168357984365.26026.8909042734026812929@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/8/23 17:04, NeilBrown wrote:
> On Tue, 09 May 2023, Jes Sorensen wrote:
>> On 4/10/23 17:54, NeilBrown wrote:
>>> On Tue, 11 Apr 2023, Jes Sorensen wrote:
>>>> Hi,
>>>>
>>>> I bumped the minimum kernel version required for mdadm to 2.6.32.
>>>>
>>>> Should we drop support for anything prior to 3.10 at this point, since
>>>> RHEL7 is 3.10 based and SLES12 seems to be 3.12 based.
>>>>
>>>> Thoughts?
>>>
>>> When you talk about changing the required kernel version, I would find
>>> it helpful if you at least mention what actual kernel features you now
>>> want to depend on - at least the more significant ones.
>>>
>>> Aside from features, I'd rather think about how old the kernel is.
>>> 2.6.32 is over 13 years old.
>>> 3.10 is very nearly 10 years old.
>>> If there is something significant that landed in 3.10 that we want to
>>> depend on, then requiring that seems perfectly reasonable.
>>>
>>> I think the oldest SLE kernel that you might care about would be 4.12
>>> (SLE12-SP5 - nearly 6 years old).  Anyone using an older SLE release
>>> values stability over new functionality and is not going to be trialling
>>> a new mdadm.
>>
>> Hi Neil,
>>
>> I guess my mindset is more that I don't expect RHEL/SLES grade distros
>> to fully upgrade mdadm, but I do see them backporting changes occasionally.
>>
>> I was mostly basing my question on what I see us testing for in the
>> actual code. Dropping support for anything prior to SLES 12 (4.12) and
>> RHEL 8 (kernel 4.18) seems fair.
> 
> So where you say "dropping support" you don't actually mean removing any
> code, but only that you will document somewhere that no effort will be
> made support, or test against, earlier kernels. Is that correct?
> Sounds reasonable to me.

There may be a few removals, or at least checks for linux kernel being
more recent than X. Otherwise yes, not planning on proactively ripping
anything out.

Cheers,
Jes


