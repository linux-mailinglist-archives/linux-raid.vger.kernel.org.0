Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D01FFE996B
	for <lists+linux-raid@lfdr.de>; Wed, 30 Oct 2019 10:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfJ3Jsw (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Oct 2019 05:48:52 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41398 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfJ3Jsw (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 30 Oct 2019 05:48:52 -0400
Received: by mail-ot1-f43.google.com with SMTP id 94so1522396oty.8
        for <linux-raid@vger.kernel.org>; Wed, 30 Oct 2019 02:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sW4YG742qXyVtK2KyRlMbb6lGflDxTvNXb6pA6EMaPU=;
        b=Uj/Sq131rRn5JiH6e61GGTjoNA0S0+MUz+5klTMVdKsd3A2e4CDKyTMrQ1nEA7gmvG
         FykCjJIQ3O6rKaT2eRX/Yl6n8Rv1fNYckkaBlQY3er1B7eLbLDnuOM0edgfNdNZb5VSd
         ARyVskB3W1yzD+7evR0CkCWxb2h3RP7VbXtQRbKZr8vztUXS3L8KJRAKEcdhxN5Ij1TU
         dcyPzzCTnFq+Uus7VJxcHyzDlCVQn7L3hAhIEF1WXr3k3RrQsvOxGAuDC08lT8JfunYg
         jXNw6Y5MrzGLN/lsxb5W5f5qiHhPzf9NN47usFiLK6MjilBihUNLAtdyQ5iMOV0BKrLJ
         Ljlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sW4YG742qXyVtK2KyRlMbb6lGflDxTvNXb6pA6EMaPU=;
        b=AbqMgGWTG8KXBpFlt5ubhWhBu5kI63Yj6IG2pX8pQ4TP/hDKzKGW0orkjy/gr0NROt
         ESmQrncYwIeHBw1R6IfN0w221bVmwopVQxJJwyCNUs4AYG0wtSwtsJor8ZAPA7LiLYd+
         PbYxLAYqQ3WwozzNosey4WJomd/Rx/6VLuXt/6IASZ4F4nzQ8kS+frDXPF5AZp6bs5xe
         zmxzH9TNBpJ20C+iJIUl67El4BMuPBqO5JPxul6sAb3GDD4d9XaeAEqdQKPDzzDfZoun
         YfczPy9Y1OAtsYsEN1chxrzSB/Xke85fui832oI00+kyWTeQyt1JC9eu5QXavKWSBrT1
         JaLA==
X-Gm-Message-State: APjAAAUj6tuUDAuFJLd9A8VHO/2cWiDGeFHwOFn726b/C5rBkaPQ3Yzn
        O/BF466ijFTB3pt2D2NE4Tz5+qTwI68UexthOheEcKke
X-Google-Smtp-Source: APXvYqw/j1mOYueOGxWWw8vaouNKoIpoTqXvMpxISMmH2uYvydEAvRKUFo3iH13q8GrrvY6rA+9ZiK3XcuEMyqAB35I=
X-Received: by 2002:a05:6830:50:: with SMTP id d16mr8877098otp.353.1572428931210;
 Wed, 30 Oct 2019 02:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191029172747.7cbe6e32@natsu> <CAHzMYBSAzB+rjixTx9DSgs48WOHkGybFGyGOEy3b7mtqnLHLgQ@mail.gmail.com>
 <eb24a24e-c268-0f3c-742a-5bde650c18dc@buttersideup.com> <20191030025346.GA24750@merlins.org>
In-Reply-To: <20191030025346.GA24750@merlins.org>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Wed, 30 Oct 2019 09:48:40 +0000
Message-ID: <CAHzMYBSTAW1y7F2DT=+bmanW=cibodfogJGA+6S4Vm+zD02GqQ@mail.gmail.com>
Subject: Re: Cannot fix Current_Pending_Sector even after check and repair
To:     Marc MERLIN <marc@merlins.org>
Cc:     Tim Small <tim@buttersideup.com>, Roman Mamedov <rm@romanrm.net>,
        linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Oct 30, 2019 at 2:53 AM Marc MERLIN <marc@merlins.org> wrote:

> I see. So somehow reading all the sectors with hdrecover does not
> trigger anything, but dd'ing 0s over the entire drive would reset this?
>

Correct, at least it usually works.
