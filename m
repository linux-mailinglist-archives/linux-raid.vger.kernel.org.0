Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085EBE56EB
	for <lists+linux-raid@lfdr.de>; Sat, 26 Oct 2019 01:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfJYXIE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 25 Oct 2019 19:08:04 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:44719 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfJYXID (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 25 Oct 2019 19:08:03 -0400
Received: by mail-qt1-f175.google.com with SMTP id z22so5682327qtq.11
        for <linux-raid@vger.kernel.org>; Fri, 25 Oct 2019 16:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBzn6lJisslfuW0z/QBmTSQZVtdONoAUSm85xXwwXQE=;
        b=O8+5HnJqgRVAabVwe30jAY5HHqkLixSOQ0l+LsLMgsSP7/73pTe6nz3lh0dkgi+mjs
         qq7cM5GV46iaQdYsOdMSb97yI8LCCKUh57B3zVNe4YrYvA0uXo14NM1pOMIhvIhpbgcQ
         EAto8dlqhvy0nLu7/Gi5Zv883FJh9DePYRApv2jfssoiDCQOpZjBUcFLt4cJdSb8PzZl
         n2UOyqcFouK1RLuUOIKvHTGjvCwYhCjGWYsg35XnhBYKT6eGiMpIF4CAQIDSE3Hr+hth
         irVAm47UqLfyntpMdEFxdNGu2hSVTC1TVNTJ6Y7SqO6KuEeHj+T92/v4g8WNytFN7bIw
         XPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBzn6lJisslfuW0z/QBmTSQZVtdONoAUSm85xXwwXQE=;
        b=qKyT2LhuH2ynt3Hspi2aBzs2HAFAe2brOUHvuV1X6haFku4LTRDCALsFQbbUktXrpO
         6IzCVsclP4fBpq2vAu/xlumzcP1tZR2ZlqiE4PwNhJ56Wy+yZ2KAVk2UUHWAxCdkIoSG
         L7sdzkScTFf+k0XTjbyNN7O/3W3iLRv7KCtd1rdsZ0fENwwGevSpsu410YOnYtvaU0sH
         8xoB3GW9/VYRtIhc7X3Eyyqsw5PPAG+KnEi1NeqJhsNQ3dnNMoVxturBR8HvGExNvdQ/
         K41pXvA4W6HNqI2Ld8WUV0wtg7Ue7IzhFY/GUb7+jhg5WbY+Jx3tc9Dz3UOczPXzHop0
         n/Nw==
X-Gm-Message-State: APjAAAVGfjVTMEn6+41aITbIzLzCcTERmfsRIimpYhNek9/+5R7gnj3+
        reb5Y4texiuvGYFTi7fV3/Vq1hM6d/EsiMwj8/Y=
X-Google-Smtp-Source: APXvYqyjun+udRNj3iuDavf8yH0k9VxHp1kGduho4U7ooE/zE6tG91R9c++YZ1GvIICQAHVyA33O0Gu1ZKMEuqlNY78=
X-Received: by 2002:ac8:2f45:: with SMTP id k5mr5786434qta.183.1572044881287;
 Fri, 25 Oct 2019 16:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191025003117.GA19595@xps13.dannf>
In-Reply-To: <20191025003117.GA19595@xps13.dannf>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 25 Oct 2019 16:07:50 -0700
Message-ID: <CAPhsuW6eYTF3AaisW+QsjEneABsh+fitw7bRz_NtD3Eo_gN0eg@mail.gmail.com>
Subject: Re: admin-guide page for raid0 layout issue
To:     dann frazier <dann.frazier@canonical.com>
Cc:     NeilBrown <neilb@suse.de>, linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Ivan Topolsky <doktor.yak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Oct 25, 2019 at 12:16 PM dann frazier
<dann.frazier@canonical.com> wrote:
>
> hey,
>   I recently hit the raid0 default_layout issue and found the warning
> message to be lacking (and google hits show that I'm not the
> only one). It wasn't clear to me that it was referring to a kernel
> parameter, also wasn't clear how I should decide which setting to use,
> and definitely not clear that picking the wrong one could *cause
> corruption* (which, AIUI, is the case). What are your thoughts on
> adding a more admin-friendly explanation/steps on resolving the
> problem to the admin-guide, and include a URL to it in the warning
> message? As prior art:
>
>   https://github.com/torvalds/linux/commit/6a012288d6906fee1dbc244050ade1dafe4a9c8d
>
> If the idea has merit, let me know if you'd like me to take a stab at
> a strawdog.

I think it is good to provide some more information for the admin.
But I am not sure whether we need to point to a url, or just put
everything in the message.

Please feel free to try add this information and submit patches.

Thanks,
Song
