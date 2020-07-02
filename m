Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F106212683
	for <lists+linux-raid@lfdr.de>; Thu,  2 Jul 2020 16:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgGBOl3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 10:41:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47886 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgGBOl2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 2 Jul 2020 10:41:28 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1jr0P1-0001n5-7v
        for linux-raid@vger.kernel.org; Thu, 02 Jul 2020 14:41:27 +0000
Received: by mail-ed1-f69.google.com with SMTP id dg19so28362639edb.6
        for <linux-raid@vger.kernel.org>; Thu, 02 Jul 2020 07:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5T1+UQfX6pEeNwUce2bRhBzSqya6/7UUz7vTij4e9c8=;
        b=Z/j7ddI7iG4Ij4R+s8N2efBIpc62+VyOZutSFOWTBnthnzNGd9eeC1CMSZtkCN9mNH
         tTqQtiC3zfN9DXJLkV1Q+z+E3koCOIUhMARc5lGwP1/h2IOgTnww3zSikBdnhUEugdsO
         MN0JwtT6cwVocKvCWqVWVWnKy83jI/MYm/7SWgQ1QfaOfnyx/sGM2vKR47ocJybjYbLq
         5lt1ll+ILvqH/Bc16R7YqN2tfzCWmmGu/J8IHenidlTUsOobFUfLlg+BJCzlVxa+2YIg
         cXqZXfdIho9IMJWdzYEyP1a8tK3ubBSlvRrWo8VY2pRyNzqh1Ue7Hz/4XM4iKfhB5psg
         tpLA==
X-Gm-Message-State: AOAM532SGZSRwe3k007GAlRngwc1K0YUC7j0Bmi0IjaxFNMmJFEsDa3l
        S4D62CZs22hM5ygh71Ok6woaqSQiSDExxmnVphHfTWT9QonbudvspHDIz6s/ZvZT2F9WK5TYVvF
        InuOcCy3c8OtJsY/qEK73xNz35WhTtKbyfLb/Vj3MlNQzhUlkD82GMds=
X-Received: by 2002:a50:f149:: with SMTP id z9mr35819638edl.167.1593700887012;
        Thu, 02 Jul 2020 07:41:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQQ7loNtaLR0+jJmnqpDfGBBHzTUDZLonufSCrcfmOD7H0vkh/Hs5ZKvmSNwfyCLMjhvtOQI4yxlNus9E8rmA=
X-Received: by 2002:a50:f149:: with SMTP id z9mr35819615edl.167.1593700886870;
 Thu, 02 Jul 2020 07:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200702113502.37408-1-colin.king@canonical.com>
In-Reply-To: <20200702113502.37408-1-colin.king@canonical.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Thu, 2 Jul 2020 11:40:51 -0300
Message-ID: <CAHD1Q_yy2gbBkd31oOJiJk2TU3K4wTV3gVtjLiQo1FW+e=5ivg@mail.gmail.com>
Subject: Re: [PATCH] md: raid0/linear: fix dereference before null check on
 pointer mddev
To:     Colin King <colin.king@canonical.com>
Cc:     Song Liu <song@kernel.org>, NeilBrown <neilb@suse.de>,
        linux-raid <linux-raid@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Great catch Colin, thanks!
Feel free to add my:

Reviewed-by: Guilherme G. Piccoli <gpiccoli@canonical.com>


P.S.  Not sure if it's only me, but the diff is soo much easier to
read when git is set to use patience diff algorithm:
https://termbin.com/f8ig
