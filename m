Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133C06BF358
	for <lists+linux-raid@lfdr.de>; Fri, 17 Mar 2023 21:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjCQU7c (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 17 Mar 2023 16:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQU7a (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 17 Mar 2023 16:59:30 -0400
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18FB367E2
        for <linux-raid@vger.kernel.org>; Fri, 17 Mar 2023 13:59:01 -0700 (PDT)
Received: from quad.stoffel.org (068-116-170-226.res.spectrum.com [68.116.170.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 4837B1E131;
        Fri, 17 Mar 2023 16:58:44 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id ED228A84C1; Fri, 17 Mar 2023 16:58:43 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25620.54403.944889.209021@quad.stoffel.home>
Date:   Fri, 17 Mar 2023 16:58:43 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Ronnie Lazar <ronnie.lazar@vastdata.com>
Cc:     linux-raid@vger.kernel.org, Asaf Levy <asaf@vastdata.com>
Subject: Re: Question about potential data consistency issues when writes failed
 in mdadm raid1
In-Reply-To: <CALM_6_s7=eyDWFkirzg6ifqeeeF6-bnZD8n7=3=V+fm_qc34AQ@mail.gmail.com>
References: <CALM_6_s7=eyDWFkirzg6ifqeeeF6-bnZD8n7=3=V+fm_qc34AQ@mail.gmail.com>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_PASS,T_SPF_HELO_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>>>> "Ronnie" == Ronnie Lazar <ronnie.lazar@vastdata.com> writes:

> I'm trying to understand how mdadm protects against inconsistent data
> read in the face of failures that occur while writing to a device that
> has raid1.

You need to give a better test case, with examples. 

> Here is the scenario: I have set up raid1 that has 2 mirrors. First
> one is on local storage and the second is on remote storage.  The
> remote storage mirror is configured with write-mostly.

Configuration details?  And what is the remote device?  

> We have parallel jobs: 1 writing to an area on the device and the
> other reading from that area.

So you create /dev/md9 and are writing/reading from it, then the
system crashes and you lose the local half of the mirror, right?

> The write operation writes the data to the first mirror, and at that
> point the read operation reads the new data from the first mirror.

So how is your write succeeding if it's not written to both halves of
the MD device?  You need to give more details and maybe even some
example code showing what you're doing here. 

> Now, before data has been written to the second (remote) mirror a
> failure has occurred which caused the first machine to fail, When
> the machine comes up, the data is recovered from the second, remote,
> mirror.

Ah... some more details.  It sounds like you have a system A which is
writing to a SITE local remote device as well as a REMOTE site device
in the MD mirror, is this correct?  

Are these iSCSI devices?  FibreChannel?  NBD devices?  More details
please.

> Now when reading from this area, the users will receive the older
> value, even though, in the first read they got the newer value that
> was written.

> Does mdadm protect against this inconsistency?

It shouldn't be returning success on the write until both sides of the
mirror are updated.  But we can't really tell until you give more
details and an example.

I assume you're not building a RAID1 device and then writing to the
individual devices behind it's back or something silly like that,
right? 

John

