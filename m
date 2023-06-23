Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D6273ADFD
	for <lists+linux-raid@lfdr.de>; Fri, 23 Jun 2023 02:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjFWAxp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 22 Jun 2023 20:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFWAxo (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 22 Jun 2023 20:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE12C2107
        for <linux-raid@vger.kernel.org>; Thu, 22 Jun 2023 17:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687481579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWfUVFfcgJbrrEHQs0fmtdNsG8h4GlA/L+9Z2Jk8wxA=;
        b=LbwPYQeN5SRYZ6BXfZKrLaRTrzvsFxZCiZ30R7xTHooGJB4WFtp6gvesYJf8XLKx2QF+Si
        7ZGynZfDktNRFtSSez0utXWBuegTtCceXT35eISDNTltuiVMlhZlCJbztlfzw0DFIg0Ycb
        MMFECH5Ds/ODkCix1+Fr1PpBwQz6sFU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-vsn6CwA4O5uOYabZp3hTuQ-1; Thu, 22 Jun 2023 20:52:58 -0400
X-MC-Unique: vsn6CwA4O5uOYabZp3hTuQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b5412be64aso377485ad.0
        for <linux-raid@vger.kernel.org>; Thu, 22 Jun 2023 17:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687481577; x=1690073577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWfUVFfcgJbrrEHQs0fmtdNsG8h4GlA/L+9Z2Jk8wxA=;
        b=GgizTu48y5nrwS+WAIMCIpCBYE62r1sCdi06QQGDUy7frIrC29iLnfdMRezQgY5XTA
         MDuOxsL8bqQjbQf4hsdEnHXwQZ2/4ZHMv48XYN3FJrTBsMR9/9BqTuYCTmQEzAhvAqrM
         0pvIzvngLPbIgazb654qL0An9tcqFfXwRbeAlMFBEJwKO+ZLLbh2gOeU0Ebum2Q2VSXn
         isYj2HpJhtjflwpINbgs75O7Q0ZHNiY8WswPKZSRYkm7tgSsuRJBy1nu2ciJdjWGn1z6
         zrVRGXBp7PLGDhCimXS5HWsdOWSSPhy+GT+0KinctwU1wfH7FErxxlZAzbZ/LhYmylyF
         Ugpw==
X-Gm-Message-State: AC+VfDxSrK1CXpRV5K587yZEzKrQWm/pcMn9n+bO0qyF6MG73cKpiNll
        6vbpIeyHimqvhoQ6VfJ2rTEeITcshH2eAwUkPH9dwIve49JgRAN5AlqaSDlh45LLzdLBepmPbxL
        3z3WiDQ0IWkpe69gWhUGXpgwsKd4U9/Yx0ZLKLyDwOGhwh+at
X-Received: by 2002:a17:903:2347:b0:1b6:b703:3703 with SMTP id c7-20020a170903234700b001b6b7033703mr2623606plh.37.1687481577114;
        Thu, 22 Jun 2023 17:52:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4YuMs06dFpFSo7j7ulcHiWun/6HP9ljo7/Rk9RPyHkz6rBfNlgBYg4scTWVbJGe0dgT15p/oh32p92P1ZoePQ=
X-Received: by 2002:a17:903:2347:b0:1b6:b703:3703 with SMTP id
 c7-20020a170903234700b001b6b7033703mr2623601plh.37.1687481576851; Thu, 22 Jun
 2023 17:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231506112411@laper.mirepesht> <82d2e7c4-1029-ec7b-a8c5-5a6deebfae31@huaweicloud.com>
 <CALTww28VaFnsBQhkbWMRvqQv6c9HyP-iSFPwG_tn2SqQVLB+7Q@mail.gmail.com>
 <20231606091224@laper.mirepesht> <20231606110134@laper.mirepesht>
 <8b288984-396a-6093-bd1f-266303a8d2b6@huaweicloud.com> <20231606115113@laper.mirepesht>
 <1117f940-6c7f-5505-f962-a06e3227ef24@huaweicloud.com> <20231606122233@laper.mirepesht>
 <20231606152106@laper.mirepesht> <cbc45f91-c341-2207-b3ec-81701a8651b5@huaweicloud.com>
 <CALTww2-Wkvxo3C2OCFrG9Wr_7RynjxnBMtPwR4GppbArZYNzsQ@mail.gmail.com> <e1097397-e477-0449-7579-348eecc81a18@youngman.org.uk>
In-Reply-To: <e1097397-e477-0449-7579-348eecc81a18@youngman.org.uk>
From:   Xiao Ni <xni@redhat.com>
Date:   Fri, 23 Jun 2023 08:52:45 +0800
Message-ID: <CALTww29_5-FmVk_2XEg_2B3-_p7=y+Wp=PUyoi4Um6BRdUiRKg@mail.gmail.com>
Subject: Re: Unacceptably Poor RAID1 Performance with Many CPU Cores
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Jun 22, 2023 at 3:34=E2=80=AFAM Wols Lists <antlists@youngman.org.u=
k> wrote:
>
> On 21/06/2023 09:05, Xiao Ni wrote:
> > Cool. And I noticed you mentioned 'fast path' in many places. What's
> > the meaning of 'fast path'? Does it mean the path that i/os are
> > submitting?
>
> It's a pretty generic kernel term, used everywhere. It's intended to be
> the normal route for whatever is going on, but it must ALWAYS ALWAYS
> ALWAYS be optimised for speed.
>
> If it hits a problem, it must back out and use the "slow path", which
> can wait, block, whatever.
>
> So the idea is that all your operations normally complete straight away,
> but if they can't they go into a different path that guarantees they
> complete, but don't block the normal operation of the system.
>
> Cheers,
> Wol
>

Hi Wol

Thanks for the explanation!

Regards
Xiao

