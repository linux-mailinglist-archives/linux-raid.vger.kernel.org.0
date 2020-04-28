Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03771BC189
	for <lists+linux-raid@lfdr.de>; Tue, 28 Apr 2020 16:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgD1Olc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 28 Apr 2020 10:41:32 -0400
Received: from atl.turmel.org ([74.117.157.138]:51267 "EHLO atl.turmel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbgD1Olc (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 28 Apr 2020 10:41:32 -0400
Received: from [98.192.104.236] (helo=[192.168.19.61])
        by atl.turmel.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <philip@turmel.org>)
        id 1jTRQR-0001Mz-3q; Tue, 28 Apr 2020 10:41:31 -0400
Subject: Re: Does a "check" of a RAID6 actually read all disks in a stripe?
To:     Brad Campbell <lists2009@fnarfbargle.com>,
        linux-raid@vger.kernel.org
References: <18271293-9866-1381-d73e-e351bf9278fd@fnarfbargle.com>
 <1ccd57ba-9d9a-d10e-4efd-dc0e8a5cf162@fnarfbargle.com>
 <e02412eb-d7f3-cea8-7398-4e5c0d749f43@turmel.org>
 <1d7fe96e-d87a-185d-1599-84cc445383cf@fnarfbargle.com>
From:   Phil Turmel <philip@turmel.org>
Message-ID: <f45df6fc-63eb-a1da-ca0c-5a3db08b454a@turmel.org>
Date:   Tue, 28 Apr 2020 10:41:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1d7fe96e-d87a-185d-1599-84cc445383cf@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/28/20 10:00 AM, Brad Campbell wrote:
> 
> On 28/4/20 9:47 pm, Phil Turmel wrote:

>> The bad block log misfeature is turned on.  Any blocks recorded in it 
>> will never be read again by MD, last I looked.  This might explain 
>> what you are seeing.
>>
>>
> While I see where you are going, the fact it corrected the bad sector by 
> re-writing it during the re-build would intimate that isn't/wasn't the 
> case.

Ah, yes.  Any chance you have set the sysfs sector limits on a check and 
haven't reset them?

Phil
