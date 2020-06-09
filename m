Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2632F1F4649
	for <lists+linux-raid@lfdr.de>; Tue,  9 Jun 2020 20:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbgFIS0O (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jun 2020 14:26:14 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:31756 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731916AbgFIS0M (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 9 Jun 2020 14:26:12 -0400
Received: from [86.173.103.225] (helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jiiws-000AGF-5r; Tue, 09 Jun 2020 19:26:11 +0100
Subject: Re: rsync input/output errors during resyncing of RAID10 e-sata,
 share changed to read-only
To:     Robert Kudyba <rkudyba@fordham.edu>, linux-raid@vger.kernel.org
References: <CAFHi+KSxLugjBpj0vFdC6xJMQrnGUrHDamqA6BcyYBt51r+wAA@mail.gmail.com>
 <CAFHi+KRL2VfyiQxEPbPQRE8Kkaj1jO+FdUcPikJxFUPN514eRg@mail.gmail.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <a54042af-a97e-5de0-b75c-33cb2cb5df76@youngman.org.uk>
Date:   Tue, 9 Jun 2020 19:26:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAFHi+KRL2VfyiQxEPbPQRE8Kkaj1jO+FdUcPikJxFUPN514eRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 09/06/2020 17:51, Robert Kudyba wrote:
> Disk /dev/sdf: 1.37 TiB, 1500301910016 bytes, 2930277168 sectors
> Disk model: ST31500341AS

Is this a Barracuda? ummmm :-(

https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

Are you running that script that fixes timeouts?

When you get things sorted, you need to check all the SMARTs.

Cheers,
Wol
