Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7560757BE27
	for <lists+linux-raid@lfdr.de>; Wed, 20 Jul 2022 20:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiGTS7Q (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 20 Jul 2022 14:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiGTS7K (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 20 Jul 2022 14:59:10 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E40675BB
        for <linux-raid@vger.kernel.org>; Wed, 20 Jul 2022 11:59:09 -0700 (PDT)
Received: from host86-158-105-35.range86-158.btcentralplus.com ([86.158.105.35] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1oEEuZ-00062b-9G;
        Wed, 20 Jul 2022 19:59:08 +0100
Message-ID: <f6f3c027-a376-66a3-c208-baf7809b85c5@youngman.org.uk>
Date:   Wed, 20 Jul 2022 19:59:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH mdadm] mdadm: Don't open md device for CREATE and ASSEMBLE
Content-Language: en-GB
To:     Logan Gunthorpe <logang@deltatee.com>, linux-raid@vger.kernel.org,
        Jes Sorensen <jsorensen@fb.com>
References: <20220714223749.17250-1-logang@deltatee.com>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <20220714223749.17250-1-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 14/07/2022 23:37, Logan Gunthorpe wrote:
> Side note: it would be nice to disable create_on_open as well to help
> solve this, but it seems the work for this was never finished. By default,
> mdadm will create using the old node interface when a name is specified
> unless the user specifically puts names=yes in a config file, which
> doesn't seem to be very common yet.

Putting ANYTHING in a config file is not that common.

I suspect there are very many systems out there, like mine, that work 
fine with auto-assemble and no config. I gather there are quite a few 
people out there who insist on having a config file, but IME it's a 
waste of time building one.

Cheers,
Wol
