Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D45D29E69B
	for <lists+linux-raid@lfdr.de>; Thu, 29 Oct 2020 09:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgJ2Iow (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 29 Oct 2020 04:44:52 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58728 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgJ2Iow (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 29 Oct 2020 04:44:52 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kXz12-0007pU-3R; Thu, 29 Oct 2020 14:54:21 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 29 Oct 2020 14:54:20 +1100
Date:   Thu, 29 Oct 2020 14:54:20 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Milan Broz <gmazyland@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Song Liu <song@kernel.org>, Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH 3/4] dm crypt: switch to EBOIV crypto API template
Message-ID: <20201029035419.GA19506@gondor.apana.org.au>
References: <20201026130450.6947-1-gilad@benyossef.com>
 <20201026130450.6947-4-gilad@benyossef.com>
 <20201026175231.GG858@sol.localdomain>
 <d07b062c-1405-4d72-b907-1c4dfa97aecb@gmail.com>
 <20201026183936.GJ858@sol.localdomain>
 <20201026184155.GA6863@gondor.apana.org.au>
 <20201026184402.GA6908@gondor.apana.org.au>
 <CAOtvUMf-xv5cHTjExW2Ffx6soLavFztow6DwE6Qo5pffF0N5uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtvUMf-xv5cHTjExW2Ffx6soLavFztow6DwE6Qo5pffF0N5uw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Oct 28, 2020 at 01:41:28PM +0200, Gilad Ben-Yossef wrote:
>
> Sorry if I'm being daft, but what did you refer to be "an existing
> option"? there was no CONFIG_EBOIV before my patchset, it was simply
> built as part of dm-crypt so it seems that setting CONFIG_EBOIV
> default to dm-crypto Kconfig option value does solves the problem, or
> have I missed something?

Oh I'm mistaken then.  I thought it was an existing option.  If
it's a new option then a default depending on dm-crypt should be
sufficient.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
