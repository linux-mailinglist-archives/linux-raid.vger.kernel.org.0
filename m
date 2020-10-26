Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308EF299591
	for <lists+linux-raid@lfdr.de>; Mon, 26 Oct 2020 19:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790199AbgJZSmN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 26 Oct 2020 14:42:13 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48796 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1774771AbgJZSmN (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 26 Oct 2020 14:42:13 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kX7RM-0006ql-2t; Tue, 27 Oct 2020 05:41:57 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 27 Oct 2020 05:41:56 +1100
Date:   Tue, 27 Oct 2020 05:41:56 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Milan Broz <gmazyland@gmail.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>, Ofir Drang <ofir.drang@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH 3/4] dm crypt: switch to EBOIV crypto API template
Message-ID: <20201026184155.GA6863@gondor.apana.org.au>
References: <20201026130450.6947-1-gilad@benyossef.com>
 <20201026130450.6947-4-gilad@benyossef.com>
 <20201026175231.GG858@sol.localdomain>
 <d07b062c-1405-4d72-b907-1c4dfa97aecb@gmail.com>
 <20201026183936.GJ858@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026183936.GJ858@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Oct 26, 2020 at 11:39:36AM -0700, Eric Biggers wrote:
> 
> CONFIG_DM_CRYPT can either select every weird combination of algorithms anyone
> can ever be using, or it can select some defaults and require any other needed
> algorithms to be explicitly selected.
> 
> In reality, dm-crypt has never even selected any particular block ciphers, even
> AES.  Nor has it ever selected XTS.  So it's actually always made users (or
> kernel distributors) explicitly select algorithms.  Why the Bitlocker support
> suddenly different?
> 
> I'd think a lot of dm-crypt users don't want to bloat their kernels with random
> legacy algorithms.

The point is that people rebuilding their kernel can end up with a
broken system.  Just set a default on EBOIV if dm-crypt is on.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
