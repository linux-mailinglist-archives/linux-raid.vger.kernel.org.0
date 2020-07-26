Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4035522DD77
	for <lists+linux-raid@lfdr.de>; Sun, 26 Jul 2020 11:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgGZJFu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 26 Jul 2020 05:05:50 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:33359 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgGZJFu (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 26 Jul 2020 05:05:50 -0400
Received: from host86-157-100-178.range86-157.btcentralplus.com ([86.157.100.178] helo=[192.168.1.64])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1jzcbM-0001ke-G6; Sun, 26 Jul 2020 10:05:49 +0100
Subject: Re: [PATCH v2 mdadm 1/1] Specify nodes number when updating cluster
 nodes
To:     Xiao Ni <xni@redhat.com>, linux-raid@vger.kernel.org,
        jes@trained-monkey.org
References: <1595503205-11129-1-git-send-email-xni@redhat.com>
Cc:     ncroxon@redhat.com, heinzm@redhat.com
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5F1D476C.4090605@youngman.org.uk>
Date:   Sun, 26 Jul 2020 10:05:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <1595503205-11129-1-git-send-email-xni@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 23/07/20 12:20, Xiao Ni wrote:
> Now it allow updating cluster nodes without specify --nodes. It can write superblock
> with zero nodes. It can break the current cluster. Add this check to avoid this problem.
> 
> v2: It needs check c.update first to void NULL pointer reference
                                       ^^^^
Do you mean "avoid"?
> 
> Signed-off-by: Xiao Ni <xni@redhat.com>
> ---
Cheers,
Wol

